Setup:

```shell
poetry install
poetry run python app.py
```

Bundle:

```
pyinstaller --onefile app.py && dist/app serve
```

# Conclusion

Apps are 117mb zipped! slow to load.

Known issues:

- click doesn't work, ie doesn't handle commandline arguments.
- onefile means the app is extracted before loading. This affects the boot performance.
