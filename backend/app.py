from flask import Flask, request
import json
from authentication import *
from speech import *

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello, welcome to the api endpoint for SIGNify!"

@app.route("/upload_video", methods = ["POST"])
def upload_video():
    """
    Api to receive video and convert ASL to text reponse 
    """
    try:

        response = convert_ASL(request)
    except Exception:
        response = {"error": 400, "message": "Error cannot convert video to text"}
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


def convert_ASL(request):
    # ML component to process video goes here
    #text = "hello"
    convert_to_speech("why u bully me")
    return {"word": "hello"}



convert_ASL("what the why sad")