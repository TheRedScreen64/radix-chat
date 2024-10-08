import cookieParser from "cookie-parser";
import cors, { CorsOptions } from "cors";
import * as dotenv from "dotenv";
import express from "express";
import rateLimit from "express-rate-limit";
import fs from "fs";
import { createServer as createHttpServer } from "http";
import { createServer as createHttpsServer } from "https";
import { WebSocketServer } from "ws";
import { lucia } from "./lib/auth.js";
import { initCronJob } from "./lib/evaluateTopics.js";
import { initWebsocket } from "./lib/websocket.js";
import { loginRouter } from "./routes/auth/login.js";
import { logoutRouter } from "./routes/auth/logout.js";
import { signupRouter } from "./routes/auth/signup.js";
import { chatRouter } from "./routes/chats/chats.js";
import { inviteRouter } from "./routes/chats/invite.js";
import { messagesRouter } from "./routes/global/messages.js";
import { todaysTopicRouter } from "./routes/topics/today.js";
import { topicRouter } from "./routes/topics/topic.js";
import { voteRouter } from "./routes/topics/vote.js";
import { existsRouter } from "./routes/user/exists.js";
import { userRouter } from "./routes/user/user.js";

if (process.env.NODE_ENV !== "production") {
   dotenv.config();
}

const errorHandler = (err: any, req: any, res: any, next: any) => {
   console.error(err);
   if (!err.status) err.status = 500;
   if (err.type) {
      switch (err.type) {
         case "entity.parse.failed":
            return res.status(err.status).send({ error: { message: "Could not parse input" } });

         default:
            return res.status(err.status).send({ error: { type: err.type } });
      }
   }
   if (err.errors) {
      return res.status(err.status).send({ error: { message: err.msg, errors: err.errors } });
   } else {
      return res.status(err.status).send({ error: { message: err.msg } });
   }
};

const authLimiter = rateLimit({
   windowMs: 60 * 1000,
   max: 5,
   message: {
      error: { message: "Too many requests, please try again later." },
   },
});
const limiter = rateLimit({
   windowMs: 60 * 1000,
   max: 100,
   message: {
      error: { message: "Too many requests, please try again later." },
   },
});

let httpsOptions = {};
let corsOptions: CorsOptions = {
   origin: "https://development.nosehad.com",
   optionsSuccessStatus: 200,
   credentials: true,
};
if (process.env.NODE_ENV === "production") {
   httpsOptions = {
      key: fs.readFileSync("/home/node/app/certs/privkey.pem"),
      cert: fs.readFileSync("/home/node/app/certs/fullchain.pem"),
   };
}
const app = express();
const server = process.env.NODE_ENV === "production" ? createHttpsServer(httpsOptions, app) : createHttpServer(app);
const wss = new WebSocketServer({ noServer: true });
const PORT = parseInt(process.env.PORT || "3000");

initCronJob();
initWebsocket(wss);

app.use(cors(corsOptions));
app.use(express.json());
app.use(cookieParser());

// const validIps = process.env.VALID_IPS ? process.env.VALID_IPS.split(",") : [];
// app.use(async (req, res, next) => {
//    if (validIps.includes(req.socket.remoteAddress ? req.socket.remoteAddress : "")) {
//       return next();
//    } else {
//       return next({ msg: `Bad IP: ${req.socket.remoteAddress}`, status: 401 });
//    }
// });

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

app.use(limiter);
app.use("/auth/login", authLimiter);
app.use("/auth/signup", authLimiter);

app.use(
   loginRouter,
   logoutRouter,
   signupRouter,
   existsRouter,
   userRouter,
   messagesRouter,
   voteRouter,
   topicRouter,
   todaysTopicRouter,
   chatRouter,
   inviteRouter
);

app.use(errorHandler);

// Route does not exist
app.use((_, res) => {
   return res.status(404).json({ error: { message: "Route not found" } });
});

server.listen(PORT, () => {
   console.log(`Listening on port ${PORT}`);
});

server.on("upgrade", async (req, socket, head) => {
   const sessionId = lucia.readSessionCookie(req.headers.cookie ?? "");
   if (!sessionId) {
      socket.write("HTTP/1.1 401 Unauthorized\r\n\r\n");
      socket.destroy();
      return;
   }

   wss.handleUpgrade(req, socket, head, (ws) => {
      req.sessionId = sessionId;
      wss.emit("connection", ws, req);
   });
});
