import cookieParser from "cookie-parser";
import * as dotenv from "dotenv";
import express from "express";
import { createServer } from "http";
import { WebSocketServer } from "ws";
import { lucia } from "./lib/auth.js";
import { initCronJob } from "./lib/evaluateTopics.js";
import { initWebsocket } from "./lib/websocket.js";
import { loginRouter } from "./routes/auth/login.js";
import { logoutRouter } from "./routes/auth/logout.js";
import { signupRouter } from "./routes/auth/signup.js";
import { mainRouter } from "./routes/index.js";
import { messagesRouter } from "./routes/messages.js";
import { todaysTopicRouter } from "./routes/topic/today.js";
import { topicRouter } from "./routes/topic/topic.js";
import { voteRouter } from "./routes/topic/vote.js";
import { existsRouter } from "./routes/user/exists.js";
import { userInfoRouter } from "./routes/user/info.js";

dotenv.config();

const jsonErrorHandler = (err: any, req: any, res: any, next: any) => {
   console.log("Moinsen error: ", err);
   res.status(500).send({ error: err });
};

const app = express();
const server = createServer(app);
const wss = new WebSocketServer({ server });
const PORT = parseInt(process.env.PORT ? process.env.PORT : "3000");

initCronJob();
initWebsocket(wss);

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

app.use(
   mainRouter,
   loginRouter,
   logoutRouter,
   signupRouter,
   existsRouter,
   userInfoRouter,
   messagesRouter,
   voteRouter,
   topicRouter,
   todaysTopicRouter
);

app.use(jsonErrorHandler);

server.listen(PORT, () => {
   console.log(`Listening on port ${PORT}`);
});
