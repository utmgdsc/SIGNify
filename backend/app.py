import os

from flask import Flask, request
import json

from authentication import *
from translation import *

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
    video.save(".\\video\\temp.mp4")
    response = translate()
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

if __name__ == "__main__":
    app.run() #debug=True for local testing