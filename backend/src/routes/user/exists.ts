import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";

export const existsRouter = express.Router();

existsRouter.post("/user/exists", async (req, res) => {
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const schema = z.object({
      email: z.string().email().optional(),
      username: z.string().min(3).max(30).optional(),
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { email, username } = parsed.data;

   let existingUser;
   if (email != null && username != null) {
      existingUser = await prisma.user.findUnique({
         where: {
            email,
            username,
         },
      });
   } else if (email != null) {
      existingUser = await prisma.user.findUnique({
         where: {
            email,
         },
      });
   } else if (username != null) {
      existingUser = await prisma.user.findUnique({
         where: {
            username,
         },
      });
   }

   if (existingUser) {
      return res.status(200).json({ exists: true });
   } else {
      return res.status(200).json({ exists: false });
   }
});