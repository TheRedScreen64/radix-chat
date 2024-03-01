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

   const requestSchema = z.object({
      title: z.string().min(1).max(100).trim(),
      description: z.string().min(1).max(1000).trim().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { title, description } = requestParams.data;

   try {
      let suggestedTopic = await prisma.user
         .findUnique({
            where: {
               id: res.locals.user.id,
            },
            select: {
               suggestedTopic: true,
            },
         })
         .suggestedTopic();
      if (suggestedTopic) {
         return res.status(400).json({ error: { message: "You already have suggested a topic today" } });
      }

      await prisma.topic.create({
         data: {
            title,
            description,
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
      console.error(err);
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

   const requestSchema = z.object({
      lastId: z.string().uuid().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
   }
   const { lastId } = requestParams.data;

   try {
      const topics = await prisma.topic.findMany({
         take: 50,
         skip: lastId ? 1 : 0,
         cursor: lastId ? { id: lastId } : undefined,
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
            votes: "desc",
         },
      });

      if (topics) {
         return res.status(200).json(topics);
      }
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to get topics: ${errorMessage}` } });
   }

   return res.status(200).send();
});
