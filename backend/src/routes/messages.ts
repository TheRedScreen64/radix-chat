import express from "express";
import { prisma } from "../lib/prisma.js";
import { z } from "zod";

export const messagesRouter = express.Router();

messagesRouter.get("/messages", async (req, res) => {
   if (!res.locals.user) {
      return res.status(401).send("Not authorized");
   }
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const schema = z.object({
      from_id: z.bigint().min(BigInt(1))
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { from_id } = parsed.data;

   let messages = await prisma.message.findMany({
      take: -50,
      skip: 1,
      cursor: {
         id: from_id
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

   if (messages) {
      return res.status(200).json(messages);
   } else {
      return res.status(404);
   }
});
