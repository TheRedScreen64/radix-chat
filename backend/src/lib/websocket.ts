import url from "url";
import { WebSocket, type WebSocketServer } from "ws";
import { z } from "zod";
import { lucia } from "./auth.js";
import { prisma } from "./prisma.js";
import { formatPrismaError } from "./utils.js";

type Message = {
   type: string;
   data: any;
};

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

      ws.on("message", async (data: string) => {
         await validateSession(ws, sessionId);

         let parsed = JSON.parse(data) as Message;

         switch (parsed.type!) {
            case "message":
               broadcast(wss, parsed, ws);
               await createMessage(parsed.data, user.id);
               break;

            default:
               break;
         }
      });
   });
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

async function createMessage(content: string, userId: string) {
   const contentSchema = z.string().min(1).max(500);

   const parsed = contentSchema.safeParse(content);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return { error: { message: "Wrong input", errors: validationErrors } };
   }

   try {
      await prisma.message.create({
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
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return { error: { message: `Failed to create the user: ${errorMessage}` } };
   }
}

export { initWebsocket };
