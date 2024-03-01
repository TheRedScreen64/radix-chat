import express from "express";
import { Argon2id } from "oslo/password";
import { z } from "zod";
import { lucia } from "../../lib/auth.js";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const loginRouter = express.Router();

loginRouter.post("/auth/login", async (req, res) => {
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const requestSchema = z.object({
      email: z.string().email(),
      password: z.string(),
      persistent: z.boolean(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { email, password, persistent } = requestParams.data;

   let existingUser;
   try {
      existingUser = await prisma.user.findUnique({
         where: {
            email,
         },
      });
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to login: ${errorMessage}` } });
   }

   if (!existingUser) {
      return res.status(400).json({ error: { message: "Incorrect username or password" } });
   }

   const validPassword = await new Argon2id().verify(existingUser.hashedPassword, password);
   if (!validPassword) {
      return res.status(400).send("Incorrect username or password");
   }

   const session = await lucia.createSession(existingUser.id, {});
   const sessionCookie = lucia.createSessionCookie(session.id);
   if (persistent == true) {
      return res.cookie(sessionCookie.name, sessionCookie.value, { maxAge: 7776000000 }).status(200).send();
   } else {
      return res.cookie(sessionCookie.name, sessionCookie.value).status(200).send();
   }
});
