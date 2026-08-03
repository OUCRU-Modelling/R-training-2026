# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this repo is

Course website for **OUCRU R training course 2026** — a [Quarto](https://quarto.org)
website project (`project: type: website`) built from `.qmd` files. Rendered
output goes to `_render/` and is published to GitHub Pages.

## Stack

- **Quarto** website project (not a book or blog)
- **R**, with package versions locked via **renv** (`renv.lock`, `.Rprofile`, `renv/`)
- Slide decks use `format: revealjs`; handouts use `format: html` (or `pdf`)

## Repository layout

| Path | Purpose |
|---|---|
| `index.qmd` | Homepage — course schedule + links to each day's slides/handouts |
| `slides/` | Lecture slide decks (`format: revealjs`), plus `Scripts/` (example R scripts) and `data/` (datasets used in slides) |
| `handouts/` | Exercises, answer keys, setup instructions (`format: html` or `pdf`) |
| `_quarto.yml` | Project-level config (theme, navbar, output dir) |
| `styles.css` | Custom CSS overrides |
| `renv/`, `renv.lock`, `.Rprofile` | R package version locking |
| `_render/` | Rendered site output — generated, not hand-edited |

## Environment setup

Before doing any R work in this project:

```r
renv::restore()
```

This installs the exact package versions pinned in `renv.lock`.

## Making changes

- New/edited **slides** go in `slides/` and must keep `format: revealjs` in the YAML header.
- New/edited **handouts** go in `handouts/` and must use `format: html` (or `pdf`).
- CSS tweaks go in `styles.css`, not inline in `.qmd` files.
- Site-wide settings (theme, navbar, etc.) live in `_quarto.yml`. A `.qmd` file's own YAML header overrides project defaults for that file only.
- If you add, remove, or update an R package used anywhere in the project, run `renv::snapshot()` before committing so `renv.lock` stays in sync.

## Build / test locally

- Live preview while editing: `quarto preview`
- One-off full render: `quarto render` → output lands in `_render/index.html`

Run one of these after editing any `.qmd` file to catch rendering errors before committing.

## Publishing

- **Do:** push commits to `main` — a GitHub Actions workflow renders and publishes the site automatically.
- **Don't:** run `quarto publish gh-pages` manually — this bypasses the intended CI-based publishing flow.

## Things to avoid

- Don't hand-edit anything under `_render/` — it's generated; edit the source `.qmd` instead.
- Don't commit a dependency change without a matching `renv::snapshot()`.
- Don't install R packages outside the project's `renv` library.
- Don't change a slide's format away from `revealjs` or a handout's away from `html`/`pdf` without good reason — downstream links in `index.qmd` assume these.