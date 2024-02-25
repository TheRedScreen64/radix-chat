import express from "express";
import { prisma } from "../lib/prisma.js";

export const messagesRouter = express.Router();

messagesRouter.get("/messages", async (req, res) => {
   if (!res.locals.user) {
      return res.status(401).send("Not authorized");
   }

   let messages = await prisma.message.findMany({
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
