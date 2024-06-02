import express from "express";
import { lucia } from "../../lib/auth.js";

export const logoutRouter = express.Router();

logoutRouter.post("/auth/logout", async (_, res, next) => {
   if (!res.locals.session) {
      return next({ msg: "Not logged in", status: 400 });
   }

   try {
      await lucia.invalidateSession(res.locals.session.id);
      const sessionCookie = lucia.createBlankSessionCookie();
      return res.cookie(sessionCookie.name, sessionCookie.value, { sameSite: "none", secure: true }).status(200).send();
   } catch (err) {
      return next({ msg: "Failed to logout", status: 500 });
   }
});
