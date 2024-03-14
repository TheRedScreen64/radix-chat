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
   "username": "USERNAME (min 3, max 30, optional)"
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

`GET /user`

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

Order: by post date desc

> Tip:
> Leave lastId undefined to get the first 50 messages,
> define lastId (as the id of the last message in the response before) to get the next 50 messages.

**Request**

`GET /global/messages`

Body:

```json
{
   "lastId": "ID OF LAST MESSAGE (uuid, optional)"
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

**Alternative: Get message info by id**
`GET /global/messages/{ID}`

## Topics - Get

Returns 50 topics

Order: by votes desc

> Tip:
> Leave lastId undefined to get the first 50 topics,
> define lastId (as the id of the last topic in the response before) to get the next 50 topics.

**Request**

`GET /topics`

Body:

```json
{
   "lastId": "ID OF LAST TOPIC (uuid, optional)"
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

**Alternative: Get topic info by id**
`GET /topics/{ID}`

## Topic - Suggest

**Request**

`POST /topics`

Body:

```json
{
   "title": "TOPIC (Min length 1, Max length 100)",
   "description": "DESCRIPTION (Optional, Min length 1, Max length 1000)"
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

## Chat - Get

Returns 50 chats

Order: by last message post date desc

> Tip:
> Leave lastId undefined to get the first 50 chats,
> define lastId (as the id of the last chat in the response before) to get the next 50 chats.

**Request**

`GET /chats`

Body:

```json
{
   "lastId": "ID OF LAST CHAT (uuid, optional)"
}
```

**Response Example**

```json
[
   {
      "id": "18c08dd5-dc91-460a-8204-e489ecd15525",
      "createdAt": "2024-03-01T22:09:14.932Z",
      "lastMessageAt": "2024-03-02T18:43:43.154Z",
      "name": "some chat",
      "description": null,
      "icon": null,
      "ownerId": "e1mg098ox3d4nun",
      "owner": {
         "name": "Günther Jauch",
         "username": "jauch3",
         "avatarUrl": null
      }
   }
]
```

**Alternative: Get chat info by id**
`GET /chats/{ID}`

## Chat - Get Messages

Returns 50 chats

Order: by last message post date desc

> Tip:
> Leave lastId undefined to get the first 50 messages,
> define lastId (as the id of the last message in the response before) to get the next 50 messages.

**Request**

`GET /chats/{ID}/messages`

Body:

```json
{
   "lastId": "ID OF LAST MESSAGE (uuid, optional)"
}
```

**Response Example**

```json
[
   {
      "id": "8ab9d1ca-d876-4c68-8eae-d22bf9f3ff4f",
      "postedAt": "2024-03-02T18:43:38.695Z",
      "updatedAt": "2024-03-02T18:43:38.695Z",
      "content": "some content",
      "userId": "e1mg098ox3d4nun",
      "chatId": "18c08dd5-dc91-460a-8204-e489ecd15525",
      "user": {
         "name": "Günther Jauch",
         "username": "jauch3",
         "avatarUrl": null
      }
   }
]
```

## Chat - Create

**Request**

`POST /chats`

Body:

```json
{
   "name": "NAME (Min 1, Max 100)",
   "description": "DESCRIPTION (Min 1, Max 1024, optional)",
   "icon": "ICON (optional)"
}
```

## Chat - Delete

**Request**

`DELETE /chats/{ID}`

## Chat - Create invite

Note: Only the chat owner can create, get and delete invites!
And an invite can only be used once!

**Request**

`POST /chats/{ID}/invites`

**Response Example**

```json
{
   "token": "some uuid",
   "expiresAt": "2024-03-15T16:37:04.438Z"
}
```

## Chat - Get invites

Note: Only the chat owner can create, get and delete invites!

**Request**

`GET /chats/{ID}/invites`

**Response Example**

```json
[
   {
      "id": "some uuid",
      "expiresAt": "2024-03-15T17:01:06.481Z",
      "token": "some uuid"
   },
   {
      "id": "some other uuid",
      "expiresAt": "2024-03-15T17:01:07.232Z",
      "token": "some other uuid"
   }
]
```

## Chat - Delete invite

Note: Only the chat owner can create, get and delete invites!

**Request**

`DELETE /chats/{CHAT_ID}/invites/{INVITE_ID}`

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

### Global message

```json
{
   "type": "globalMessage",
   "data": {
      "content": "string (min 1, max 2000)"
   }
}
```

### Chat message

```json
{
   "type": "chatMessage",
   "data": {
      "chatId": "string (uuid)",
      "content": "string (min 1, max 2000)"
   }
}
```
