import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";

export function formatPrismaError(error: any) {
   if (error instanceof PrismaClientKnownRequestError && error.meta != undefined) {
      if (error.message.includes("Unique constraint failed on the fields")) {
         return `Unique constraint failed on ${error.meta.target!.toString()}`;
      }
      return error.meta.cause;
   } else {
      return "Unknown Error";
   }
}
