# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

FROM node:24-alpine AS deps

WORKDIR /app

RUN corepack enable

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/frontend/package.json apps/frontend/package.json

RUN pnpm install --frozen-lockfile


# ------------------------------------------------------------------------------
# Build
# ------------------------------------------------------------------------------

FROM node:24-alpine AS build

WORKDIR /app

RUN corepack enable

COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/apps/frontend/node_modules ./apps/frontend/node_modules

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/frontend ./apps/frontend

RUN pnpm --filter frontend build


# ------------------------------------------------------------------------------
# Production
# ------------------------------------------------------------------------------

FROM node:24-alpine AS production

WORKDIR /app

ENV NODE_ENV=production

COPY --from=build /app/apps/frontend/build ./build

EXPOSE 3000

USER node

CMD ["node", "build"]