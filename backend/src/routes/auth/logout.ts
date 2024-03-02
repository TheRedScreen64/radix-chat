import express from "express";
import { lucia } from "../../lib/auth.js";

export const logoutRouter = express.Router();

logoutRouter.post("/auth/logout", async (_, res, next) => {
   if (!res.locals.session) {
      return res.send("Not logged in");
   }

   try {
      await lucia.invalidateSession(res.locals.session.id);
      const sessionCookie = lucia.createBlankSessionCookie();
      return res.cookie(sessionCookie.name, sessionCookie.value).status(200).send();
   } catch (err) {
      return next({ msg: "Failed to logout", status: 500 });
   }
});
