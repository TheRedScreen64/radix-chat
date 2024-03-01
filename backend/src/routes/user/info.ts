import express from "express";
import { prisma } from "../../lib/prisma.js";

export const userInfoRouter = express.Router();

userInfoRouter.get("/user/info", async (_, res) => {
   if (!res.locals.user) {
      return res.status(401).send("Not authorized");
   }

   let user = await prisma.user.findUnique({
      where: {
         id: res.locals.user.id,
      },
      select: {
         id: true,
         email: true,
         name: true,
         username: true,
         avatarUrl: true,
         suggestedTopics: true,
         votedTopics: true,
      },
   });

   if (user) {
      return res.status(200).json(user);
   } else {
      return res.status(404).send("User not found");
   }
});
