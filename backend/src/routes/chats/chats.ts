import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const chatRouter = express.Router();

chatRouter.post("/chats", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      name: z.string().trim().min(1).max(100),
      description: z.string().trim().min(1).max(1024).optional(),
      icon: z.string().url().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   const { name, description, icon } = requestParams.data;

   try {
      await prisma.chat.create({
         data: {
            name,
            description,
            icon,
            participants: {
               connect: {
                  id: res.locals.user.id,
               },
            },
            owner: {
               connect: {
                  id: res.locals.user.id,
               },
            },
         },
      });
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to create chat: ${errorMessage}`, status: 500 });
   }

   return res.status(200).send();
});

chatRouter.get("/chats", async (req, res, next) => {
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
   const { lastId } = requestParams.data;

   try {
      const chats = await prisma.chat.findMany({
         take: 50,
         skip: lastId ? 1 : 0,
         cursor: lastId ? { id: lastId } : undefined,
         where: {
            participants: {
               some: {
                  id: res.locals.user.id,
               },
            },
         },
         include: {
            owner: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
         },
         orderBy: {
            lastMessageAt: "desc",
         },
      });

      if (chats) {
         return res.status(200).json(chats);
      } else {
         return next({ msg: "No chats found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get chats: ${errorMessage}`, status: 500 });
   }
});

chatRouter.get("/chats/:id", async (req, res, next) => {
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
      const chat = await prisma.chat.findUnique({
         where: {
            id,
            participants: {
               some: {
                  id: res.locals.user.id,
               },
            },
         },
         include: {
            owner: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
            participants: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
         },
      });

      if (chat) {
         return res.status(200).json(chat);
      } else {
         return next({ msg: "Chat not found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get chat: ${errorMessage}`, status: 500 });
   }
});

chatRouter.delete("/chats/:id", async (req, res, next) => {
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
      await prisma.chat.delete({
         where: {
            id,
            ownerId: res.locals.user.id,
         },
      });

      return res.status(200).send();
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to delete chat: ${errorMessage}`, status: 500 });
   }
});

chatRouter.get("/chats/:id/messages", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const data = { ...req.params, ...req.body };

   const requestSchema = z.object({
      id: z.string().uuid(),
      lastId: z.string().uuid().optional(),
   });

   const requestParams = requestSchema.safeParse(data);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input or parameters", status: 400, errors: validationErrors });
   }
   const { id, lastId } = requestParams.data;

   try {
      const chat = await prisma.chat.findUnique({
         where: {
            id,
            participants: {
               some: {
                  id: res.locals.user.id,
               },
            },
         },
         include: {
            messages: {
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
            },
         },
      });

      if (!chat) {
         return next({ msg: "Chat not found", status: 404 });
      }

      return res.status(200).json(chat.messages);
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get chat messages: ${errorMessage}`, status: 500 });
   }
});

chatRouter.post("/chats/:id/invites", async (req, res, next) => {
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

chatRouter.get("/chats/:id/invites", async (req, res, next) => {
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

chatRouter.delete("/chats/:chatId/invites/:inviteId", async (req, res, next) => {
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

chatRouter.post("/chat/invite/:token", async (req, res, next) => {
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
