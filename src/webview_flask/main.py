#!/usr/bin/env python3
import os
import webview
import sys
from flask import Flask

if getattr(sys, "frozen", False):
    template_folder = os.path.join(sys._MEIPASS, "templates")
    static_folder = os.path.join(sys._MEIPASS, "static")
    app = Flask(__name__, template_folder=template_folder, static_folder=static_folder)
else:
    app = Flask(__name__)


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


def main():
    if not (sys.version_info >= (3, 8) and sys.version_info < (3, 12)):
        print("Python version is not between 3.8 and 3.11.")
        sys.exit(1)

    webview.create_window("Hello world", app)
    webview.start()


if __name__ == "__main__":
    main()
