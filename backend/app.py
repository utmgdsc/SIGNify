from flask import Flask, request
import json
from authentication import *
from history import *

app = Flask(__name__)


@app.route("/")
def index():
    return "Hello, welcome to the api endpoint for SIGNify!"


@app.route("/upload_video", methods=["POST"])
def upload_video():
    """
    Api to receive video and convert ASL to text reponse 
    """
    video = request.get_json()
    try:
        response = convert_ASL(video["id"], video["video"])
    except Exception:
        response = {"error": 400, "message": "Error cannot convert video to text"}
    return json.dumps(response)


@app.route("/register", methods=["POST"])
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


@app.route("/login", methods=["POST"])
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


@app.route("/history", methods=["GET"])
def get_history():
    """
        Api to retrieve user history
    """
    # convert request json to dictionary
    user_id = request.args.get("id")
    history = retrieve_history(user_id)
    # create json and pass back to flutter
    response = {"history": history}
    return json.dumps(response)


def convert_ASL(user_id, video):
    # ML component to process video goes here
    text = 'hello'

    if user_id:
        store_translation(user_id, text)
    return {"text": text}


if __name__ == "__main__":
    app.run()  # debug=True for local testing
