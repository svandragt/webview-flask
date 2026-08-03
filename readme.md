Proof of concept using web technologies for UI, and python to produce a desktop application. 

The stack is currently:

- uv: python version and dependency management
- pywebview: qt/gtk webview
- flask: local server and web framework
- pex: packaging
- makefile: build configuration

This produces a 4mb executable, runnable by Python 3.12 and up. Tested on ubuntu 22.04.

![image](https://github.com/svandragt/webview-flask/assets/594871/1a1c452a-8ee8-4954-a6ed-f9b019333008)


## Installation

Multiple options:

1. Build the executable (see below), OR
2. Install using pipx: `pipx install webview-flask`


# Contributing

The project can also run from a venv:

Setup:

```shell
uv sync --dev
uv run webview-flask
```

Run the tests:

```shell
uv run pytest
```

Makefile:

- `make build`: use `pex` to build a single executable (`dist/webview_flask`) with Python 3.12+ as its only dependency.
- `make run-build`: run it.
