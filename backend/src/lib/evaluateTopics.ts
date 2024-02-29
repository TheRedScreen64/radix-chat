import cron from "node-cron";
import { prisma } from "./prisma.js";

async function evaluateTopics() {
   const votedTopic = await prisma.topic
      .findFirst({
         orderBy: {
            votes: "desc",
         },
      })
      .catch((err) => {
         console.error(err);
         return;
      });

   if (!votedTopic) return;

   await prisma.topic.deleteMany({
      where: { id: { not: votedTopic.id } },
   });

   await prisma.keyValue.upsert({
      where: {
         id: "topicOfTheDay",
      },
      update: { value: votedTopic.id },
      create: { id: "topicOfTheDay", value: votedTopic.id },
   });
}

async function initCronJob() {
   cron.schedule("0 0 * * *", async () => {
      await evaluateTopics();
   });
   await evaluateTopics();
}

export { initCronJob };
