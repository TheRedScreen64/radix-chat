import { PrismaClient } from "@prisma/client";
import "http";
import type { Session, User } from "lucia";

declare global {
   namespace Express {
      interface Locals {
         user: User | null;
         session: Session | null;
      }
   }
   var prisma: PrismaClient;
}

declare module "http" {
   interface IncomingMessage {
      sessionId: string | null;
   }
}

export {};
