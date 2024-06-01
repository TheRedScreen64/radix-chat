import express from "express";
import { z } from "zod";
import { prisma } from "../../lib/prisma.js";
import { formatPrismaError } from "../../lib/utils.js";

export const existsRouter = express.Router();

existsRouter.post("/user/exists", async (req, res, next) => {
   // if (!res.locals.user) {
   //    return next({ msg: "Not authorized", status: 401 });
   // }
   if (!req.body) {
      return next({ msg: "No input provided", status: 400 });
   }

   const requestSchema = z.object({
      email: z.string().email().optional(),
      username: z.string().min(3).max(30).optional(),
   });

   const requestParams = requestSchema.safeParse(req.body);
   if (!requestParams.success) {
      const validationErrors = requestParams.error.flatten().fieldErrors;
      return next({ msg: "Wrong input", status: 400, errors: validationErrors });
   }
   const { email, username } = requestParams.data;

   try {
      let existingUser;
      if (email != null && username != null) {
         existingUser = await prisma.user.findUnique({
            where: {
               email,
               username,
            },
         });
      } else if (email != null) {
         existingUser = await prisma.user.findUnique({
            where: {
               email,
            },
         });
      } else if (username != null) {
         existingUser = await prisma.user.findUnique({
            where: {
               username,
            },
         });
      }

      if (existingUser) {
         return res.status(200).json({ exists: true });
      } else {
         return res.status(200).json({ exists: false });
      }
   } catch (err) {
      const errorMessage = formatPrismaError(err);
      return res.status(500).json({ error: { message: `Failed to check if user exists: ${errorMessage}` } });
   }
});
