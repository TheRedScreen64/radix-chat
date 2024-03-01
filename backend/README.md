# Run

Install npm packages

```bash
pnpm install
```

Set DATABASE_URL environment variable in .env file (must be a postgres database)
e.g. "postgresql://postgres:password@host:port/postgres?schema=public"

Either run database migration if using new database

```bash
pnpx prisma migrate dev --name init
```

or generate prisma client

```bash
pnpx prisma generate
```

Start the dev server

```bash
pnpm dev
```

# API

## Auth - Signup

**Request**

`POST /auth/signup`

Body:

```json
{
   "email": "EMAIL",
   "username": "USERNAME (Min length 3, Max length 30)",
   "name": "REAL NAME (Min length 1, Max length 50)",
   "password": "PASSWORD (Min length 6, Max length 255)",
   "persistent": "REMEMBER USER (bool)"
}
```

## Auth - Login

**Request**

`POST /auth/login`

Body:

```json
{
   "email": "EMAIL",
   "password": "PASSWORD",
   "persistent": "REMEMBER USER (bool)"
}
```

## Auth - Logout

**Request**

`POST /auth/logout`

## User - Exists

Returns true if a user with this email and/or username does already exist.

**Request**

`POST /user/exists`

Body:

```json
{
   "email": "EMAIL (optional)",
   "username": "USERNAME (optional)"
}
```

**Response Example**

```json
{
   "exists": false
}
```

## User - Info

Returns all information about the user

**Request**

`GET /user/info`

**Response Example**

```json
{
   "id": "123xyz",
   "email": "some@mail.com",
   "name": "Werner Sauerkraut",
   "username": "werner",
   "avatarUrl": "https://img.unocero.com/2021/08/rickroll_4k-1024x768.jpeg",
   "suggestedTopic": {...},
   "votedTopics": []
}
```

## Messages - Get

Returns 50 messages

> Tip:
> Don't define lastId to get the first 50 messages,
> define lastId to get 50 messages after the last topic of the messages fetched before.

**Request**

`GET /messages`

Body:

```json
{
   "lastId": "ID OF LAST FETCHED MESSAGE (uuid, optional)"
}
```

**Response Example**

```json
[
   {
      "id": "df4fcf62-c0a8-4f52-a015-fdf8ab06c139",
      "postedAt": "2024-02-25T12:20:22.262Z",
      "updatedAt": "2024-02-25T12:20:22.262Z",
      "content": "some content \nsupports linebreaks 👌",
      "userId": "xyz123",
      "user": {
         "name": "Werner Sauerkraut",
         "username": "werner",
         "avatarUrl": "https://img.unocero.com/2021/08/rickroll_4k-1024x768.jpeg"
      }
   }
]
```

## Topics - Get

Returns 50 topics

> Tip:
> Don't define lastId to get the first 50 topics,
> define lastId to get 50 topics after the last topic of the topics fetched before.

**Request**

`GET /topics`

Body:

```json
{
   "lastId": "ID OF LAST FETCHED TOPIC (uuid, optional)"
}
```

**Response Example**

```json
[
   {
      "id": "ca9e0073-94f6-42a5-a534-7bb42de5f6e9",
      "suggestedAt": "2024-02-27T19:03:00.755Z",
      "title": "some title",
      "description": null,
      "votes": 12,
      "authorId": "123xyz",
      "author": {
         "name": "Werner Sauerkraut",
         "username": "werner",
         "avatarUrl": "https://img.unocero.com/2021/08/rickroll_4k-1024x768.jpeg"
      }
   },
   {
      "id": "d5745b1d-555d-4742-b520-145480ed4ef6",
      "suggestedAt": "2024-02-27T18:45:18.204Z",
      "title": "some title",
      "description": "some desc.",
      "votes": 201,
      "authorId": "123xyz",
      "author": {
         "name": "Werner Sauerkraut",
         "username": "werner",
         "avatarUrl": "https://img.unocero.com/2021/08/rickroll_4k-1024x768.jpeg"
      }
   }
]
```

## Topic - Suggest

**Request**

`POST /topic`

Body:

```json
{
   "title": "TOPIC (Min length 1, Max length 100)",
   "description": "DESCRIPTION (Optional, Min length 1, Max length 1000)
}
```

## Topic - Vote

**Request**

`POST /topic/vote`

Body:

```json
{
   "topicId": "TOPIC ID (uuid)"
}
```

## Topic - Today

Returns the topic of the day.

**Request**

`GET /topic/today`

**Response Example**

```json
{
   "title": "some title",
   "description": "some desc.",
   "votes": 1,
   "authorId": "8jq36o0lxfq76ed",
   "author": {
      "name": "Günther Jauch",
      "username": "jauch",
      "avatarUrl": null
   }
}
```

# Websocket

**Request structure**

```json
{
   "type": "string (see below at 'Message Types')",
   "data": "any"
}
```

## Example usage

```js
const ws = new WebSocket("ws://host:port?session=sessionId");

ws.onopen = () => {
   // Send Message
   ws.send(JSON.stringify({ type: "message", data: "moinsen" }));
};

ws.onmessage = ({ data }) => {
   let parsed = JSON.parse(data);
   switch (parsed.type) {
      case "message":
         let li = document.createElement("li");
         li.innerText = parsed.data;
         document.querySelector(".list").appendChild(li);
         console.log(`Received message: ${parsed.data}`);
         break;

      default:
         break;
   }
};
```

## Message Types

### Global message:

```json
{
   "type": "message",
   "data": "string"
}
```
