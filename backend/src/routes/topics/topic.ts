import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const topicRouter = express.Router();

topicRouter.post("/topics", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      title: z.string().trim().min(1).max(100),
      description: z.string().trim().min(1).max(1000).optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
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
         return next({ msg: "You have already suggested a topic today", status: 400 });
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
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to create topic: ${errorMessage}`, status: 500 });
   }

   return res.status(200).send();
});

topicRouter.get("/topics", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      lastId: z.string().uuid().optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
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
      } else {
         return next({ msg: "No topics found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get topics: ${errorMessage}`, status: 500 });
   }
});

topicRouter.get("/topics/:id", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      id: z.string().uuid().optional(),
   });

   const requestParams = requestSchema.safeParse(req.params);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong parameters", status: 400, errors: validationErrors });
   }
   const { id } = requestParams.data;

   try {
      const topic = await prisma.topic.findUnique({
         where: {
            id,
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
      });

      if (topic) {
         return res.status(200).json(topic);
      } else {
         return next({ msg: "No topic found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get topic: ${errorMessage}`, status: 500 });
   }
});
