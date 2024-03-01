import cron from "node-cron";
import { prisma } from "./prisma.js";

async function evaluateTopics() {
   const topVotedTopic = await prisma.topic
      .findFirst({
         select: {
            title: true,
            description: true,
            authorId: true,
            author: {
               select: {
                  name: true,
                  username: true,
                  avatarUrl: true,
               },
            },
            votes: true,
         },
         orderBy: {
            votes: "desc",
         },
      })
      .catch((err) => {
         console.error(err);
         return;
      });

   if (!topVotedTopic) return;

   await prisma.topic.deleteMany();

   await prisma.keyValue.upsert({
      where: {
         key: "topicOfTheDay",
      },
      update: { value: topVotedTopic },
      create: { key: "topicOfTheDay", value: topVotedTopic },
   });
}

async function initCronJob() {
   cron.schedule("0 0 * * *", async () => {
      await evaluateTopics();
   });

   let today = new Date();
   today.setHours(0, 0, 0, 0);

   let topicOfTheDay = await prisma.keyValue.findUnique({
      where: {
         key: "topicOfTheDay",
      },
   });
   if (!topicOfTheDay || topicOfTheDay.updatedAt < today) {
      await evaluateTopics();
   }
}

export { initCronJob };
