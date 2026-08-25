# ReFrame Frontend

The frontend is the public-facing experience for ReFrame, a social news platform built to expose framing, bias, and narrative construction in media coverage.

## What this app does

This SvelteKit app presents the reader-facing experience for:

- submitting and discovering news links and article summaries
- viewing the original article alongside community framing notes
- reading sarcastic rewrites that highlight how tone and language shape public perception
- voting, commenting, and discussing bias in context
- browsing topic clusters, trusted sources, and creator-driven analysis

The product is designed to make media literacy feel social, interactive, and intentionally provocative without replacing the source material.

## User experience goals

The frontend is meant to feel:

- fast and readable
- community-driven
- skeptical but constructive
- visually clear enough to surface differences between source, framing, and commentary

## Architecture

This app is intentionally kept separate from the backend API and acts as the presentation layer for the ReFrame platform.

- SvelteKit provides routing, server rendering, and component-based UI composition
- the frontend communicates with the Go backend through API endpoints
- the app is designed to run behind a reverse proxy in local Docker development

## Local development

From the monorepo root:

```sh
pnpm install
pnpm dev:web
```

Or run the app directly from the frontend directory:

```sh
cd apps/frontend
pnpm install
pnpm dev
```

## Build and validation

```sh
pnpm --filter frontend build
pnpm --filter frontend check
pnpm --filter frontend lint
```

## Product tone

The UI reflects the app's mission: not to cynically dismiss journalism, but to make framing visible and encourage critical reading habits.
