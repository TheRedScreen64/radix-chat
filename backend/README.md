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
   "password": "PASSWORD (Min length 6, Max length 255)"
}
```

**Response**

Success

## Auth - Login

**Request**

`POST /auth/login`

Body:

```json
{
   "email": "EMAIL",
   "password": "PASSWORD"
}
```

**Response**

Success

## Auth - Logout

**Request**

`POST /auth/logout`

**Response**

Success
