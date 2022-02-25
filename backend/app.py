from flask import Flask, request
import json
from authentication import *

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
    account = json.load(request)
    result = register_account(account["email"], account["password"])
    response = {"result": result}
    return json.dumps(response)

@app.route("/login", methods = ["POST"])
def login():
    account = json.load(request)
    result = login_account(account["email"], account["password"])
    response = {"result": result}
    return json.dumps(response)


def convert_ASL(request):
    # ML component to process video goes here
    return {"word": "hello"}