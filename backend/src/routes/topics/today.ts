import { JsonObject } from "@prisma/client/runtime/library";
import express from "express";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const todaysTopicRouter = express.Router();

todaysTopicRouter.get("/topic/today", async (_, res, next) => {
   try {
      let topicOfTheDay = await prisma.keyValue.findUnique({
         where: {
            key: "topicOfTheDay",
         },
      });
      if (!topicOfTheDay) {
         return next({ msg: "Topic of the day not defined", status: 404 });
      }

      let topic = topicOfTheDay.value as JsonObject;
      if (!topic) {
         return next({ msg: "Topic of the day not defined", status: 404 });
      }

      return res.status(200).json(topic);
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get topic of today: ${errorMessage}`, status: 500 });
   }
});
