import express from "express";
import { lucia } from "../../lib/auth.js";

export const logoutRouter = express.Router();

logoutRouter.post("/logout", async (req, res) => {
   if (!res.locals.session) {
      return res.send("Not logged in");
   }

   console.log(res.locals.session.id);
   await lucia.invalidateSession(res.locals.session.id);
   const sessionCookie = lucia.createBlankSessionCookie();
   return res.appendHeader("Set-Cookie", sessionCookie.serialize()).status(200).send("");
});
