import express from "express";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const todaysTopicRouter = express.Router();

todaysTopicRouter.get("/topic/today", async (_, res) => {
   try {
      let topicOfTheDay = await prisma.keyValue.findUnique({
         where: {
            key: "topicOfTheDay",
         },
      });
      if (!topicOfTheDay) {
         return res.status(500).json({ error: { message: `The topic of today is not set` } });
      }

      let topic = await prisma.topic.findUnique({
         where: {
            id: String(topicOfTheDay.value),
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
      if (!topic) {
         return res.status(500).json({ error: { message: `The topic of today was not found` } });
      }

      return res.status(200).json(topic);
   } catch (err) {
      console.error(err);
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to get the topic of today: ${errorMessage}` } });
   }
});
