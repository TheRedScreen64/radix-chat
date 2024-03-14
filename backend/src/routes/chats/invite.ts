import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const inviteRouter = express.Router();

inviteRouter.post("/chats/:id/invites", async (req, res, next) => {
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
   const { id } = requestParams.data;

   let expiresAt = new Date();
   expiresAt.setHours(expiresAt.getHours() + 24);

   try {
      const exists = await prisma.chat.findUnique({
         where: {
            id,
            ownerId: res.locals.user.id,
         },
      });

      if (!exists) {
         return next({ msg: "Chat not found", status: 404 });
      }

      const invite = await prisma.invite.create({
         data: {
            chat: {
               connect: {
                  id,
               },
            },
            expiresAt,
         },
      });

      return res.status(200).json({ token: invite.token, expiresAt: invite.expiresAt });
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to create invite: ${errorMessage}`, status: 500 });
   }
});

inviteRouter.get("/chats/:id/invites", async (req, res, next) => {
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
   const { id } = requestParams.data;

   try {
      const invites = await prisma.invite.findMany({
         where: {
            chat: {
               id,
               ownerId: res.locals.user.id,
            },
         },
         orderBy: {
            expiresAt: "asc",
         },
         select: {
            id: true,
            expiresAt: true,
            token: true,
         },
      });

      if (invites) {
         return res.status(200).json(invites);
      } else {
         return next({ msg: "No invites found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get chat invites: ${errorMessage}`, status: 500 });
   }
});

inviteRouter.delete("/chats/:chatId/invites/:inviteId", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      chatId: z.string().uuid(),
      inviteId: z.string().uuid(),
   });

   const requestParams = requestSchema.safeParse(req.params);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong parameters", status: 400, errors: validationErrors });
   }
   const { chatId, inviteId } = requestParams.data;

   try {
      await prisma.invite.delete({
         where: {
            id: inviteId,
            chat: {
               id: chatId,
               ownerId: res.locals.user.id,
            },
         },
      });

      return res.status(200).send();
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to delete invite: ${errorMessage}`, status: 500 });
   }
});

inviteRouter.post("/chat/invite/:token", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      token: z.string().uuid(),
   });

   const requestParams = requestSchema.safeParse(req.params);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input or parameters", status: 400, errors: validationErrors });
   }
   const { token } = requestParams.data;

   try {
      const invite = await prisma.invite.findUnique({
         where: {
            token,
         },
      });

      if (!invite || invite.expiresAt < new Date()) {
         return next({ msg: "Invite is invalid or expired", status: 404 });
      }

      await prisma.chat.update({
         where: {
            id: invite.chatId,
         },
         data: {
            participants: {
               connect: {
                  id: res.locals.user.id,
               },
            },
         },
      });

      await prisma.invite.delete({
         where: {
            token,
         },
      });

      return res.status(200).send();
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to validate invite: ${errorMessage}`, status: 500 });
   }
});
