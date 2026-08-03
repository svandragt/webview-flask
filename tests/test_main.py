from webview_flask.main import app


def test_hello_world():
    response = app.test_client().get("/")
    assert response.status_code == 200
    assert b"Hello, World!" in response.data
