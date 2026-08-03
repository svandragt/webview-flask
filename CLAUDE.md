# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A proof of concept: a desktop app built from web technologies. Flask serves the UI, pywebview
renders it in a native window (Qt/GTK), and pex packages the whole thing into a single ~4MB
executable that only needs a system Python (3.8–3.11) to run.

All application code lives in `src/webview_flask/main.py` — it creates the Flask app and starts
the webview window. There is no other module.

## Commands

Setup and run from a venv:
```shell
poetry install
poetry run webview-flask
```

Build the standalone executable:
```shell
make build       # exports requirements.txt, builds dist/webview_flask with pex
make run-build    # build, then run dist/webview_flask.pex
make publish      # poetry build && poetry publish
```

There is no test suite or linter configured.

## Architecture notes

- `main.py` branches on `sys.frozen` to locate `templates`/`static` under `sys._MEIPASS` when
  running as a frozen/packaged executable, vs. normal Flask defaults when running from source.
- `main()` enforces the Python 3.8–3.11 constraint at runtime (pywebview's GTK/Qt backends don't
  support 3.12+) and exits before starting the webview window if violated.
- The Makefile's `build` target is the source of truth for how packaging actually works: it
  regenerates `requirements.txt` from Poetry (`poetry export --without-hashes`), then runs `pex`
  against the current directory to produce a single-file executable with entry point
  `webview_flask.main:main`.
- `dist/` is a build artifact directory (checked into git in this repo's current state) — don't
  hand-edit anything under it; regenerate via `make build`.
