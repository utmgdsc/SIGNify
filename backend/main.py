from flask import Flask, request
import json
from authentication import *
from history import *

app = Flask(__name__)


@app.route("/")
def index():
    return "Hello, welcome to the api endpoint for SIGNify!"


@app.route("/register", methods=["POST"])
def register():
    """
        Api to receive user account info and register it in firebase
    """
    # parse request as json
    account = request.get_json()
    user_id = register_account(account["email"], account["password"])
    # create json to pass back to flutter
    response = {"id": user_id}
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


@app.route("/history", methods=["POST"])
def post_history():
    """
    Api to receive translation and store it to database
    """
    try:
        history = request.get_json()
        user_id = history["id"]
        if user_id:
            store_translation(user_id, history["translation"])
        response = {"message": "success"}
    except:
        response = {"message": "error"}
    return json.dumps(response)


if __name__ == "__main__":
    app.run()  # debug=True for local testing
