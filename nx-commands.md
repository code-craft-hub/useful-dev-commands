### NX DEMON NOT RUNNING

nx reset
nx daemon

### Create a workspace

pnpm nx g @nx/nest:lib --name=domain --directory=libs/shared --importPath=@app/shared-domain --linter=none --unitTestRunner=none

pnpm create nx-workspace cverai-monorepo --preset=nest

pnpm create nx-workspace appName

### Run nx projects

pnpm exec nx run cverai-monorepo:serve

### Add a Plugin

pnpm nx add @nx/nest

### Remove an app

pnpm nx g @nx/workspace:remove appName

### Generate nest app

nx g @nx/nest:app apps/api-gateway

### Generate Libraries

pnpm nx g @nx/node:lib common --directory=directoryName --importPath=@workspace/**-**

### Nestjs generators

pnpm nx g @nx/nest:module users --project=api
pnpm nx g @nx/nest:controller users --project=api
pnpm nx g @nx/nest:service users --project=api
pnpm nx g @nx/nest:lib auth

### Run a target

pnpm nx run api:serve OR pnpm nx serve api
pnpm nx run api:build OR pnpm nx build api
pnpm nx run api:test OR pnpm nx test api
pnpm nx run api:lint OR pnpm nx lint api

### Configure nx mcp server

pnpm dlx nx@latest configure-ai-agents

### Add nest to nx

nx add @nx/nest

### Run all projects

pnpm nx run-many -t serve --all

### Build a project

nx build projectName

### Test a project

nx test projectName

### Run a particular command

pnpm --filter <"name of the app. e.g: @cverai-monorepo/cverai-monorepo"> <"command e.g build">

### Initialized NX

nx@latest init

### Affected projects

pnpm nx affected:build
pnpm nx affected:test
pnpm nx affected:lint

### Workspace Inspection

pnpm nx show projects
pnpm nx show project api
pnpm nx graph
pnpm nx graph --focus=api

### Testing/Quality

pnpm nx test api
pnpm nx lint api
pnpm nx format:check
pnpm nx format:write

### Reset Nx Cache

pnpm nx reset
pnpm nx show cache

### Migrate Nx

pnpm nx migrate latest
pnpm nx migrate --run-migrations

### Repair workspace

pnpm nx repair
