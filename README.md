# Opus Classical

Using Gleam!

## Development

Have [Gleam](https://gleam.run/getting-started/installing) installed.

Have [Bun](https://bun.sh/docs/installation) installed.

Install packages:

- `$ bun install`
- `$ gleam deps download`

Build Tailwind:

- `$ bunx tailwindcss -i ./assets/app.css -o ./priv/static/app.css` once
- `$ bunx tailwindcss -i ./assets/app.css -o ./priv/static/app.css --watch` in watch mode

Have `.env` with env vars:

```dotenv
POSTGRES_USER=postgres.name
POSTGRES_PASSWORD=passowrd
POSTGRES_HOST=aws-0-eu-central-1.pooler.supabase.com
POSTGRES_DATABASE=postgres
POSTGRES_PORT=5432
SERVER_PORT=8000
SECRET_KEY=asj3lw4_Sd5klysgf_gg3111
```

Run the server:

- `$ gleam run`
