import os

from flask import Flask, request
import json

from werkzeug.utils import secure_filename

from authentication import *

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello, welcome to the api endpoint for SIGNify!"

@app.route("/upload_video", methods=["POST"])
def upload_video():
    """
    Api to receive video and convert ASL to text reponse
    """
    user_id = request.form.get("id")
    video = request.files['video']
    response = convert_ASL(user_id, video)
    return json.dumps(response)

@app.route("/register", methods = ["POST"])
def register():
    """
        Api to receive user account info and register it in firebase
    """
    # parse request as json
    account = request.get_json()
    result = register_account(account["email"], account["password"])
    # create json to pass back to flutter
    response = {"result": result}
    return json.dumps(response)

@app.route("/login", methods = ["POST"])
def login():
    """
        Api to receive user account info, verify it and login user
    """
    # convert request json to dictionary
    account = request.get_json()
    user_id = login_account(account["email"], account["password"])
    # create json and pass back to flutter
    response = {"id": user_id}
    return json.dumps(response)


def convert_ASL(user_id, video):
    # ML component to process video goes here
    text = 'hello'
    filename = secure_filename(video.filename)
    video.save(os.path.join(os.getcwd(), filename))

    return {"text": text}

if __name__ == "__main__":
    app.run() #debug=True for local testing