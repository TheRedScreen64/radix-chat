import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const messagesRouter = express.Router();

messagesRouter.get("/global/messages", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      lastId: z.string().uuid().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   let { lastId } = requestParams.data;

   try {
      const messages = await prisma.globalMessage.findMany({
         take: 50,
         skip: lastId ? 1 : 0,
         cursor: lastId ? { id: lastId } : undefined,
         include: {
            user: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
         },
         orderBy: {
            postedAt: "desc",
         },
      });

      if (messages) {
         return res.status(200).json(messages);
      } else {
         return next({ msg: "No messages found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get messages: ${errorMessage}`, status: 500 });
   }
});

messagesRouter.get("/global/messages/:id", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      id: z.string().uuid(),
   });

   const requestParams = requestSchema.safeParse(req.params);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong parameters", status: 400, errors: validationErrors });
   }
   let { id } = requestParams.data;

   try {
      const message = await prisma.globalMessage.findUnique({
         where: {
            id,
         },
         include: {
            user: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
         },
      });

      if (message) {
         return res.status(200).json(message);
      } else {
         return next({ msg: "Message not found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get message: ${errorMessage}`, status: 500 });
   }
});
