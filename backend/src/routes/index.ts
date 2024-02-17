import express from "express";

export const mainRouter = express.Router();

mainRouter.get("/", async (_, res) => {
   if (!res.locals.user) {
      return res.send("Not authorized");
   }

   return res.json({
      username: res.locals.user.username,
      user_id: res.locals.user.id,
   });
});
