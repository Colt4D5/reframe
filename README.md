# ReFrame

ReFrame is a social news platform designed to surface how stories are framed, filtered, and reinterpreted by both legacy media and everyday audiences. The app lets users share news links, rewrite them in a deliberately sarcastic tone to highlight framing bias, and discuss the underlying narratives behind the headlines.

The core idea is simple: the platform does not just report the news — it shows how the news is shaped by incentives, language choices, and audience assumptions.

## Why this exists

Modern news feeds are saturated with headlines that sound neutral but carry an editorial slant. People consume stories at scale, often without recognizing the framing, bias, or agenda behind them.

ReFrame reverses that pattern:

- articles are submitted and shared publicly
- each post can be rewritten in a sarcastic, exaggerated voice to expose framing
- users can tag likely bias categories such as political lean, sensationalism, omission, or agenda-setting
- discussions center on how the article was told, not just what happened

This helps readers see the difference between factual content and narrative packaging.

## Core product goals

- Make bias visible without pretending it is always easy to prove
- Encourage critical reading habits rather than blind cynicism
- Let users share news with context and commentary
- Give each article a personality through tone, angle, and sarcasm
- Turn a comment section into a media literacy discussion

## Platform concept

ReFrame is intended to be part social network, part media analysis tool, and part satire-driven commentary space.

Users can:

- submit a link or article summary
- add their own context or source notes
- rewrite the article in a sarcastic tone that reveals framing bias
- label the article with categories like left-leaning, right-leaning, sensationalist, business-first, activist, or citizen commentary
- upvote or discuss interpretations from other readers
- follow topics, publications, and creators who consistently highlight bias patterns

## Features roadmap

### MVP

- article submission and link preview
- post title, summary, and source metadata
- sarcastic rewrite mode
- bias tagging and source labels
- upvote/downvote and comment threads
- user authentication and profile pages

### Phase 2

- article comparison view: original vs sarcastic rewrite vs neutral summary
- publication bias profiles
- AI-assisted bias detection suggestions
- moderation tools and community guidelines
- topic clusters and trending narratives

### Phase 3

- creator dashboards
- newsletters or digest curation
- subscriptions for curated bias analysis
- exportable reading lists and source dossiers

## Product tone

The tone of the app is intentionally skeptical and humorous, but not meaningless. The sarcastic rewrite is not meant to replace the original article; it is meant to highlight how tone, framing, and language can push a story toward a perspective.

The platform is built around the idea that:

- satire can be a tool for deeper media literacy
- bias becomes more obvious when you see it exaggerated
- civic curiosity beats passive consumption

## Tech stack

This repository is structured as a monorepo with a Go backend and a SvelteKit frontend.

- Frontend: SvelteKit with Node adapter
- Backend: Go
- Proxy: Nginx
- Containerization: Docker Compose
- Database: PostgreSQL (planned)
- Search and indexing: planned for article metadata and posts

## Repository structure

- apps/backend — Go API and data layer
- apps/frontend — SvelteKit frontend
- apps/docker — Docker and reverse proxy config
- README.md — project overview and contributor guide

## Local development

The app is intended to run behind a reverse proxy so the frontend and backend share the same host.

Typical routing:

- / → frontend app
- /api/* → Go backend

Example:

- http://localhost/ → SvelteKit app
- http://localhost/api/health → backend health route

## Environment conventions

The backend and frontend should default to same-origin API access via the reverse proxy.

Frontend env example:

```env
PUBLIC_API_URL=/api
```

Backend env example:

```env
PORT=8080
```

## Development workflow

1. Start the backend
2. Start the frontend
3. Run the reverse proxy
4. Access the site via localhost and proxy-routed /api paths

## Contribution values

- challenge framing, not just facts
- be curious about sources and motives
- keep critique grounded and constructive
- make bias visible without becoming performative
- treat satire as explanation, not as a replacement for truth

## Notes

This project is intentionally opinionated. It exists to help people question how narratives are packaged, not to endorse misinformation or hostility. The platform is designed to foster critical reading and constructive discussion around media literacy.

## License

This project is currently unlicensed. Add a license before production use if you plan to distribute or deploy it publicly.
