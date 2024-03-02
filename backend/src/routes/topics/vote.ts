import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const voteRouter = express.Router();

voteRouter.post("/topic/vote", async (req, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const schema = z.object({
      topicId: z.string().uuid(),
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   const { topicId } = parsed.data;

   try {
      await prisma.topic.update({
         where: {
            id: topicId,
            voters: {
               none: {
                  id: res.locals.user.id,
               },
            },
         },
         data: {
            voters: {
               connect: {
                  id: res.locals.user.id,
               },
            },
            votes: {
               increment: 1,
            },
         },
      });
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      if (errorMessage === "There is no Topic that meets the requirements") {
         return next({ msg: "You have already voted for this topic or it does not exist", status: 400 });
      }
      return next({ msg: `Failed to vote for topic: ${errorMessage}`, status: 500 });
   }

   return res.status(200).send();
});
