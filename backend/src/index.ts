import express from "express";
import * as dotenv from "dotenv";
import cors from "cors";
import { lucia } from "./lib/auth.js";
import { mainRouter } from "./routes/index.js";
import { loginRouter } from "./routes/login/route.js";
import { signupRouter } from "./routes/signup/route.js";
import { logoutRouter } from "./routes/logout/index.js";
import cookieParser from "cookie-parser";

dotenv.config();

const app = express();
const PORT = parseInt(process.env.PORT ? process.env.PORT : "3000");

// app.use(cors);
app.use(express.json());
app.use(cookieParser());

app.use(async (req, res, next) => {
   const sessionId = lucia.readSessionCookie(req.headers.cookie ?? "");
   if (!sessionId) {
      res.locals.user = null;
      res.locals.session = null;
      return next();
   }

   const { session, user } = await lucia.validateSession(sessionId);
   if (session && session.fresh) {
      res.appendHeader("Set-Cookie", lucia.createSessionCookie(session.id).serialize());
   }
   if (!session) {
      res.appendHeader("Set-Cookie", lucia.createBlankSessionCookie().serialize());
   }
   res.locals.session = session;
   res.locals.user = user;
   return next();
});

app.use(mainRouter, loginRouter, logoutRouter, signupRouter);

app.listen(PORT, () => {
   console.log(`Listening on port ${PORT}`);
});
