import express from "express";
import { Argon2id } from "oslo/password";
import { z } from "zod";
import { lucia } from "../../lib/auth.js";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const userRouter = express.Router();

userRouter.get("/user", async (_, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }

   try {
      const user = await prisma.user.findUnique({
         where: {
            id: res.locals.user.id,
         },
         select: {
            id: true,
            email: true,
            name: true,
            username: true,
            avatarUrl: true,
            suggestedTopic: true,
            votedTopics: true,
         },
      });

      if (user) {
         return res.status(200).json(user);
      } else {
         return next({ msg: "User not found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get user: ${errorMessage}`, status: 500 });
   }
});

userRouter.patch("/user", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      email: z.string().email().trim().toLowerCase().optional(),
      username: z
         .string()
         .trim()
         .min(3)
         .max(30)
         .toLowerCase()
         .transform((value) => value.replace(/[^a-zA-Z0-9-]/g, ""))
         .optional(),
      name: z.string().trim().min(1).max(50).optional(),
      password: z.string().trim().min(6).max(255).optional(),
      // TODO: Add avatarUrl whitelist
      avatarUrl: z.string().trim().url().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   const { email, username, name, password, avatarUrl } = requestParams.data;

   let hashedPassword: string | undefined;
   if (password) {
      hashedPassword = await new Argon2id().hash(password);
   }

   try {
      const updatedUser = await prisma.user.update({
         where: {
            id: res.locals.user.id,
         },
         data: {
            email: email ?? undefined,
            username: username ?? undefined,
            name: name ?? undefined,
            hashedPassword: hashedPassword ?? undefined,
            avatarUrl: avatarUrl ?? undefined,
         },
         select: {
            id: true,
            email: true,
            name: true,
            username: true,
            avatarUrl: true,
            suggestedTopic: true,
            votedTopics: true,
         },
      });

      return res.status(200).json(updatedUser);
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to update user: ${errorMessage}`, status: 500 });
   }
});

userRouter.delete("/user", async (_, res, next) => {
   if (!res.locals.user || !res.locals.session) {
      return next({ msg: "Not authorized", status: 401 });
   }

   try {
      await prisma.user.delete({
         where: {
            id: res.locals.user.id,
         },
      });

      await lucia.invalidateSession(res.locals.session.id);
      const sessionCookie = lucia.createBlankSessionCookie();
      return res.cookie(sessionCookie.name, sessionCookie.value, { sameSite: "none", secure: true }).status(200).send();
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to delete user: ${errorMessage}`, status: 500 });
   }
});
