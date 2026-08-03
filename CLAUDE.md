# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A proof of concept: a desktop app built from web technologies. Flask serves the UI, pywebview
renders it in a native window (GTK on Linux), and pex packages the whole thing into a single
~4MB executable that only needs a system Python (3.12+) to run.

All application code lives in `src/webview_flask/main.py` — it creates the Flask app and starts
the webview window. There is no other module.

## Commands

Setup and run from a venv:
```shell
uv sync --dev
uv run webview-flask
```

Test and lint:
```shell
uv run pytest        # runs with coverage, fails under 90%
uv run ruff check .
```

Build the standalone executable:
```shell
make build       # exports requirements.txt, builds dist/webview_flask with pex
make run-build    # build, then run dist/webview_flask
make publish      # uv build && uv publish
```

## Architecture notes

- `main.py` branches on `sys.frozen` to locate `templates`/`static` under `sys._MEIPASS` when
  running as a frozen/packaged executable, vs. normal Flask defaults when running from source.
  That branch is marked `# pragma: no cover` — it only runs inside a frozen build.
- `main()` (also `# pragma: no cover`) starts the webview window; it needs a real display, so
  it isn't exercised by the test suite. Tests hit the Flask app directly via `app.test_client()`.
- The Makefile's `build` target is the source of truth for how packaging actually works: it
  regenerates `requirements.txt` via `uv export` (which already includes the local project as
  `-e .`), then runs `pex -r requirements.txt` (no separate `.` argument — that would duplicate
  the project and break resolution) to produce a single-file executable with entry point
  `webview_flask.main:main`.
- `pywebview[gtk]` pulls in PyGObject, which builds from source on Linux and needs system GTK
  dev headers (see `.github/workflows/ci.yml` for the apt package list).
- `dist/` and `requirements.txt` are build artifacts and gitignored — regenerate via `make build`,
  don't hand-edit or commit them.

## CI and dependency updates

- `.github/workflows/ci.yml` runs `ruff check` and `pytest` on every push/PR. The `test` job is a
  required status check on `main` (branch protection).
- `.github/dependabot.yml` opens weekly update PRs for `uv` and `github-actions` dependencies.
- `.github/workflows/dependabot-auto-merge.yml` auto-merges dependabot PRs for patch/minor bumps
  once CI passes; major-version bumps are left for manual review.
