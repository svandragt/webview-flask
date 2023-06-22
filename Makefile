bootstrap:
	rm -rf dist/
	poetry install
	poetry export -o requirements.txt --without-hashes

build: bootstrap
	poetry run pex --python=$(OUTPUT) -v . -r requirements.txt -o dist/webview_flask.pex -e webview_flask.main:main
	cd dist
	unzip webview_flask.pex
	zip -r webview_flask.pex.zip webview_flask.pex
	cd ..

build-run: build
	dist/webview_flask.pex
