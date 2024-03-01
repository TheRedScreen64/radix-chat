import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const topicRouter = express.Router();

topicRouter.post("/topic", async (req, res) => {
   if (!res.locals.user) {
      return res.status(401).send("Not authorized");
   }
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const schema = z.object({
      content: z.string().min(1).max(100).trim(),
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { content } = parsed.data;

   try {
      await prisma.topic.create({
         data: {
            content,
            author: {
               connect: {
                  id: res.locals.user.id,
               },
            },
            voters: {
               connect: {
                  id: res.locals.user.id,
               },
            },
         },
      });
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to create the topic: ${errorMessage}` } });
   }

   return res.status(200).send();
});

topicRouter.get("/topics", async (req, res) => {
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


   try {
      let topics = await prisma.topic.findMany({
         take: 50,
         skip: 1,
         cursor: {
            id: from_id
         },
         include: {
            author: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
         },
         orderBy: {
            votes: "desc"
         }
      });

      if (topics) {
         return res.status(200).json(topics);
      }
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to fetch all topics: ${errorMessage}` } });
   }

   return res.status(200).send();
});
