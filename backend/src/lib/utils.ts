import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";

export function formatPrismaError(error: any): string {
   if (error instanceof PrismaClientKnownRequestError && error.meta != undefined) {
      if (error.message.includes("Unique constraint failed on the fields")) {
         return `Unique constraint failed on ${error.meta.target!.toString()}`;
      } else if (error.message.includes("Required exactly one parent ID to be present for connect query")) {
         return `There is no ${error.meta.modelName!} that meets the requirements`;
      } else if (error.meta.field_name?.toString().includes("Chat_ownerId_fkey (index)")) {
         // TODO: Is Cascade better?
         return `There is at least one chat owned by this user, please delete or transfer them to another user first`;
      }
      return String(error.meta.cause);
   } else {
      return "Unknown Error";
   }
}
