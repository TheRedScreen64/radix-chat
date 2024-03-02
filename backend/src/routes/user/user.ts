import express from "express";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const userInfoRouter = express.Router();

userInfoRouter.get("/user", async (_, res, next) => {
   if (!res.locals.user) {
      return next({ msg: "Not authorized", status: 401 });
   }

   try {
      const user = await prisma.user.findUnique({
         where: {
            id: res.locals.user.id,
         },
         select: {
            id: true,
            email: true,
            name: true,
            username: true,
            avatarUrl: true,
            suggestedTopic: true,
            votedTopics: true,
         },
      });

      if (user) {
         return res.status(200).json(user);
      } else {
         return next({ msg: "User not found", status: 404 });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return next({ msg: `Failed to get user: ${errorMessage}`, status: 500 });
   }
});
