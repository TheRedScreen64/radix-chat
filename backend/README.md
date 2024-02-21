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

**Response Example**

Success

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

**Response Example**

Success

## Auth - Logout

**Request**

`POST /auth/logout`

**Response Example**

Success

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
