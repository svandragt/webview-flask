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
