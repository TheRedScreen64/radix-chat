import { DatabaseUser, Lucia } from "lucia";
import { PrismaAdapter } from "@lucia-auth/adapter-prisma";
import { prisma } from "./prisma.js";

const adapter = new PrismaAdapter(prisma.session, prisma.user);

const lucia = new Lucia(adapter, {
   sessionCookie: {
      attributes: {
         secure: process.env.NODE_ENV === "production",
      },
   },
   getUserAttributes: (attributes) => {
      return {
         username: attributes.username,
      };
   },
});

declare module "lucia" {
   interface Register {
      Lucia: typeof lucia;
      DatabaseUserAttributes: DatabaseUserAttributes;
   }
}

interface DatabaseUserAttributes {
   username: string;
}

export { lucia };
