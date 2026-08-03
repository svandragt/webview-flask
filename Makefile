build:
	rm -rf dist/
	uv sync --dev
	uv export --no-dev --no-hashes -o requirements.txt
	uv run pex -v -r requirements.txt -o dist/webview_flask -e webview_flask.main:main --python-shebang="/usr/bin/env python3"
	unzip dist/webview_flask -d dist/
	zip -jr dist/webview_flask.zip dist/webview_flask

run-build: build
	dist/webview_flask

test:
	uv run pytest

publish:
	uv build
	uv publish
