import express from "express";
import { lucia } from "../../lib/auth.js";

export const logoutRouter = express.Router();

logoutRouter.post("/auth/logout", async (req, res) => {
   if (!res.locals.session) {
      return res.send("Not logged in");
   }

   await lucia.invalidateSession(res.locals.session.id);
   const sessionCookie = lucia.createBlankSessionCookie();
   return res.cookie(sessionCookie.name, sessionCookie.value).status(200).send();
});
