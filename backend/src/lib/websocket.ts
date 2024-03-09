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

const connections = new Map<string, any>();
const limiter = {
   timeWindowMs: 60 * 1000,
   limit: 100,
};

function initWebsocket(wss: WebSocketServer) {
   wss.on("connection", async (ws, req) => {
      if (!req.socket.remoteAddress) {
         ws.close();
         return;
      }
      const ip = req.socket.remoteAddress;
      let connection = connections.get(ip);
      if (!connection) {
         connection = {
            count: 0,
            lastMessageTime: Date.now(),
         };
         connections.set(ip, connection);
      }

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
            const exceededRateLimit = await checkRateLimit(connection!);
            if (exceededRateLimit) {
               return ws.send(JSON.stringify({ error: { message: "Rate limit exceeded" } }));
            }

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
                  // TODO: Add global chat rate limits
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

async function checkRateLimit(connection: any): Promise<boolean> {
   console.log(connection);
   const now = Date.now();
   const elapsedTime = now - connection.lastMessageTime;

   if (elapsedTime < limiter.timeWindowMs) {
      connection.count++;
      if (connection.count > limiter.limit) {
         return true;
      }
   } else {
      connection.count = 1;
      connection.lastMessageTime = now;
   }
   return false;
}

function broadcast(wss: WebSocketServer, data: any, skip: WebSocket | null) {
   wss.clients;
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
