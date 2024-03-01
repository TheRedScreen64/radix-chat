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
         key: "topicOfTheDay",
      },
      update: { value: votedTopic.id },
      create: { key: "topicOfTheDay", value: votedTopic.id },
   });
}

async function initCronJob() {
   cron.schedule("0 0 * * *", async () => {
      await evaluateTopics();
   });

   let today = new Date()
   today.setHours(0, 0, 0, 0)
   
   let topicOfTheDay = await prisma.keyValue.findUnique({
      where: {
         key: "topicOfTheDay"
      }
   })
   if (!topicOfTheDay) {
      await evaluateTopics()
   } else if (topicOfTheDay.updatedAt < today) {
      await evaluateTopics()
   }
}

export { initCronJob };
