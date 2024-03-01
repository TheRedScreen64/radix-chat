import express from "express";
import { z } from "zod";
import { prisma } from "../lib/prisma.js";
import { formatPrismaError } from "../lib/utils.js";

export const messagesRouter = express.Router();

messagesRouter.get("/messages", async (req, res) => {
   if (!res.locals.user) {
      return res.status(401).send("Not authorized");
   }
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const requestSchema = z.object({
      lastId: z.string().uuid().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   let { lastId } = requestParams.data;

   try {
      const messages = await prisma.message.findMany({
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
            postedAt: "asc",
         },
      });

      if (messages) {
         return res.status(200).json(messages);
      } else {
         return res.status(404);
      }
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to get messages: ${errorMessage}` } });
   }
});
