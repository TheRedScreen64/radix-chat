import express from "express";
import { generateId } from "lucia";
import { Argon2id } from "oslo/password";
import { z } from "zod";
import { lucia } from "../../lib/auth.js";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const signupRouter = express.Router();

signupRouter.post("/auth/signup", async (req, res) => {
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const schema = z.object({
      email: z.string().email().trim().toLowerCase(),
      username: z.string().min(3).max(30).trim().toLowerCase(),
      name: z.string().min(1).max(50).trim(),
      password: z.string().min(6).max(255).trim(),
      persistent: z.boolean(),
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { email, username, name, password, persistent } = parsed.data;

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
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to create the user: ${errorMessage}` } });
   }

   const session = await lucia.createSession(userId, {});
   const sessionCookie = lucia.createSessionCookie(session.id);
   if (persistent == true) {
      return res.cookie(sessionCookie.name, sessionCookie.value, { maxAge: 7776000000 }).status(200).send("Success");
   } else {
      return res.cookie(sessionCookie.name, sessionCookie.value).status(200).send("Success");
   }
});
