import cron from "node-cron";
import { prisma } from "./prisma.js";

async function evaluateTopics() {
   const topVotedTopic = await prisma.topic
      .findFirst({
         orderBy: {
            votes: "desc",
         },
      })
      .catch((err) => {
         console.error(err);
         return;
      });

   if (!topVotedTopic) return;

   await prisma.topic.deleteMany({
      where: { id: { not: topVotedTopic.id } },
   });

   await prisma.keyValue.upsert({
      where: {
         key: "topicOfTheDay",
      },
      update: { value: topVotedTopic.id },
      create: { key: "topicOfTheDay", value: topVotedTopic.id },
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
