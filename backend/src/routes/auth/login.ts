import express from "express";
import { Argon2id } from "oslo/password";
import { z } from "zod";
import { lucia } from "../../lib/auth.js";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const loginRouter = express.Router();

loginRouter.post("/auth/login", async (req, res, next) => {
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      email: z.string().email(),
      password: z.string(),
      persistent: z.boolean(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   const { email, password, persistent } = requestParams.data;

   try {
      const existingUser = await prisma.user.findUnique({
         where: {
            email,
         },
      });
      if (!existingUser) {
         return next({ msg: "Incorrect username or password", status: 400 });
      }

      const validPassword = await new Argon2id().verify(existingUser.hashedPassword, password);
      if (!validPassword) {
         return next({ msg: "Incorrect username or password", status: 400 });
      }

      const session = await lucia.createSession(existingUser.id, {});
      const sessionCookie = lucia.createSessionCookie(session.id);
      if (persistent == true) {
         return res.cookie(sessionCookie.name, sessionCookie.value, { maxAge: 7776000000, sameSite: "none" }).status(200).send();
      } else {
         return res.cookie(sessionCookie.name, sessionCookie.value, { sameSite: "none" }).status(200).send();
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to login: ${errorMessage}`, status: 500 });
   }
});
