from flask import Flask
from aws import get_objects
import os

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route("/audio")
def audio():
    return f"<p>This is a audio route! {get_objects('mp3')} </p>"


@app.route("/video")
def video():
    return f"<p>This is a video route! {get_objects('mp4')} </p>"


@app.route("/images")
def images():
    return f"<p>This is a images route! {get_objects('png')} </p>"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=os.getenv("DEBUG_MODE") == "True")
