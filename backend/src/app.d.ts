import { PrismaClient } from "@prisma/client";
import type { User, Session } from "lucia";

declare global {
   namespace Express {
      interface Locals {
         user: User | null;
         session: Session | null;
      }
   }
   var prisma: PrismaClient;
}

export {};
