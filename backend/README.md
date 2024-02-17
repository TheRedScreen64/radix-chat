# Run

Install npm packages

```bash
pnpm install
```

Set DATABASE_URL environment variable in .env file
e.g. "postgresql://postgres:password@host:port/postgres?schema=public"

Run database migration

```bash
pnpx prisma migrate dev --name init
```

Start the dev server

```bash
pnpm dev
```
