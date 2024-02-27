import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const voteRouter = express.Router();

voteRouter.post("/topic/vote", async (req, res) => {
   if (!res.locals.user) {
      return res.status(401).send("Not authorized");
   }
   if (!req.body) {
      return res.status(400).json({ error: { message: "No input provided" } });
   }

   const schema = z.object({
      topicId: z.number().min(1),
   });

   const parsed = schema.safeParse(req.body);
   if (!parsed.success) {
      const validationErrors = parsed.error.flatten().fieldErrors;
      return res.status(400).json({ error: { message: "Wrong input", errors: validationErrors } });
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
      console.error(err);
      const errorMessage = formatPrismaError(err);
      // NOTE: Error message when already voted: There is no Topic that meets the requirements
      return res.status(500).json({ error: { message: `Failed to vote for the topic: ${errorMessage}` } });
   }

   return res.status(200).send();
});
