bootstrap:
	rm -rf dist/
	poetry install
	poetry export -o requirements.txt --without-hashes
	poetry run black "src/webview_flask/"

build: bootstrap
	poetry run pex -v . -r requirements.txt -o dist/webview_flask.pex -e webview_flask.main:main --python-shebang="/usr/bin/env python3"
	unzip dist/webview_flask.pex -d dist/
	zip -jr dist/webview_flask.pex.zip dist/webview_flask.pex

run: build
	dist/webview_flask.pex
