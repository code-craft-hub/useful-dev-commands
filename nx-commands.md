pnpm dlx create-nx-workspace@latest my-fullstack-app --pm pnpm

### Configure nx mcp server
pnpm dlx nx@latest configure-ai-agents  

### Add nest to nx
nx add @nx/nest

### Generate nest app
nx g @nx/nest:app apps/api-gateway

### Run all projects
nx run-many -t serve --all

### Build a project
nx build projectName

### Test a project
nx test projectName