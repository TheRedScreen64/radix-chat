import express from "express";
import { Argon2id } from "oslo/password";
import { lucia } from "../../lib/auth.js";
import { generateId } from "lucia";
import { prisma } from "../../lib/prisma.js";
import { z } from "zod";
import { formatPrismaError } from "../../lib/utils.js";

export const signupRouter = express.Router();

signupRouter.post("/signup", async (req, res) => {
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const schema = z.object({
      email: z.string().email(),
      username: z.string().min(3).max(30),
      password: z.string().min(6).max(255),
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { email, username, password } = parsed.data;

   const userId = generateId(15);
   const hashedPassword = await new Argon2id().hash(password);

   try {
      await prisma.user.create({
         data: {
            id: userId,
            email,
            username,
            hashedPassword,
         },
      });
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to create the user: ${errorMessage}` } });
   }

   const session = await lucia.createSession(userId, {});
   const sessionCookie = lucia.createSessionCookie(session.id);
   return res.appendHeader("Set-Cookie", sessionCookie.serialize()).status(200).send("Success");
});
