Proof of concept using web technologies for UI, and python to produce a desktop application.

The stack is currently:

- pyenv: manage python versions.
- poetry: python dependency management
- pywebview: qt/gtk webview
- flask: local server and web framework
- pex: packaging
- makefile: build configuration


# Contributing

The project can also run from a venv:

Setup:

```shell
poetry install
poetry run webview-flask
```

Makefile:

- `build`: use `pex` to build a single executable (`dist/webview_flask`) with Python 3.8-3.11 as its only dependency. Flask requires 3.8.
- `run-build`: run it.
