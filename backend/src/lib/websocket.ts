import { User } from "lucia";
import url from "url";
import { WebSocket, type WebSocketServer } from "ws";
import { z } from "zod";
import { lucia } from "./auth.js";
import { prisma } from "./prisma.js";
import { formatPrismaError } from "./utils.js";

const messageSchema = z.object({
   type: z.enum(["globalMessage", "chatMessage"]),
   data: z.any().optional().default({}),
});

// TODO: Overhaul

function initWebsocket(wss: WebSocketServer) {
   wss.on("connection", async (ws, req) => {
      let sessionId = url.parse(req.url!, true).query.session!;
      if (!sessionId || Array.isArray(sessionId)) {
         ws.close();
         return;
      }

      const { session, user } = await lucia.validateSession(sessionId);
      if (!session || !user) {
         ws.close();
         return;
      }

      ws.on("error", console.error);

      ws.on("message", async (reqData: string) => {
         try {
            await validateSession(ws, sessionId);

            let reqJson = JSON.parse(reqData);
            let parsed = messageSchema.safeParse(reqJson);
            if (!parsed.success) {
               const validationErrors = parsed.error.flatten().fieldErrors;
               return ws.send(JSON.stringify({ error: { message: "Wrong input", errors: validationErrors } }));
            }
            const { type, data } = parsed.data;

            switch (type) {
               case "globalMessage": {
                  handleGlobalMessage(ws, wss, data, user);
                  break;
               }
               case "chatMessage": {
                  handleChatMessage(ws, data, user);
                  break;
               }

               default:
                  break;
            }
         } catch (err) {
            await ws.send(JSON.stringify({ error: { message: `Failed to parse the message: ${err}` } }));
         }
      });
   });
}

async function handleGlobalMessage(ws: WebSocket, wss: WebSocketServer, data: any, user: User) {
   const requestSchema = z.object({
      content: z.string().trim().min(1).max(2000),
   });

   const requestParams = requestSchema.safeParse(data);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return ws.send(JSON.stringify({ error: { message: "Wrong input", errors: validationErrors } }));
   }
   const { content } = requestParams.data;

   broadcast(wss, content, ws);
   await createMessage(ws, content, user.id);
}

async function handleChatMessage(ws: WebSocket, data: any, user: User) {
   const requestSchema = z.object({
      chatId: z.string().uuid(),
      content: z.string().trim().min(1).max(2000),
   });

   const requestParams = requestSchema.safeParse(data);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return ws.send(JSON.stringify({ error: { message: "Wrong input", errors: validationErrors } }));
   }
   const { chatId, content } = requestParams.data;

   try {
      await prisma.chat.update({
         where: {
            id: chatId,
            participants: {
               some: {
                  id: user.id,
               },
            },
         },
         data: {
            lastMessageAt: new Date(),
            messages: {
               create: {
                  content,
                  user: {
                     connect: {
                        id: user.id,
                     },
                  },
               },
            },
         },
      });
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      if (errorMessage.includes("No 'Chat' record (needed to inline the relation on 'ChatMessage' record) was found")) {
         return ws.send(JSON.stringify({ error: { message: "Chat not found" } }));
      }
      return ws.send(JSON.stringify({ error: { message: `Failed to create message: ${errorMessage}` } }));
   }
}

async function validateSession(ws: WebSocket, sessionId: string | string[]) {
   if (Array.isArray(sessionId)) {
      ws.close();
      return;
   }
   const { session, user } = await lucia.validateSession(sessionId);
   if (!session || !user) {
      ws.close();
      return;
   }
}

function broadcast(wss: WebSocketServer, data: any, skip: WebSocket | null) {
   wss.clients.forEach((client) => {
      if (skip && client == skip) return;
      if (client.readyState === WebSocket.OPEN) {
         client.send(JSON.stringify(data));
      }
   });
}

async function createMessage(ws: WebSocket, content: string, userId: string) {
   try {
      await prisma.globalMessage.create({
         data: {
            content,
            user: {
               connect: {
                  id: userId,
               },
            },
         },
      });
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return ws.send(JSON.stringify({ error: { message: `Failed to create message: ${errorMessage}` } }));
   }
}

export { initWebsocket };
