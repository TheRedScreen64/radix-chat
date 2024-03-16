import express from "express";
import { generateId } from "lucia";
import { Argon2id } from "oslo/password";
import { z } from "zod";
import { lucia } from "../../lib/auth.js";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const signupRouter = express.Router();

signupRouter.post("/auth/signup", async (req, res, next) => {
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      email: z.string().email().trim().toLowerCase(),
      username: z
         .string()
         .trim()
         .min(3)
         .max(30)
         .toLowerCase()
         .transform((value) => value.replace(/[^a-zA-Z0-9-]/g, "")),
      name: z.string().trim().min(1).max(50),
      password: z.string().trim().min(6).max(255),
      persistent: z.boolean(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   const { email, username, name, password, persistent } = requestParams.data;

   const userId = generateId(15);
   const hashedPassword = await new Argon2id().hash(password);

   try {
      await prisma.user.create({
         data: {
            id: userId,
            email,
            username,
            name,
            hashedPassword,
         },
      });

      const session = await lucia.createSession(userId, {});
      const sessionCookie = lucia.createSessionCookie(session.id);
      if (persistent == true) {
         return res.cookie(sessionCookie.name, sessionCookie.value, { maxAge: 7776000000 }).status(200).send();
      } else {
         return res.cookie(sessionCookie.name, sessionCookie.value).status(200).send();
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to create user: ${errorMessage}`, status: 500 });
   }
});
