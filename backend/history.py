import json

import pyrebase

firebaseJSON = open('firebase.json')
firebaseConfig = json.load(firebaseJSON)

# initialize firebase
firebase = pyrebase.initialize_app(firebaseConfig)
# access firebase real-time database
db = firebase.database()


def retrieve_history(user_id):
    history = db.child("user").child(user_id).child("history").get()
    if history.val() is None:
        return []
    else:
        return history.val()


def store_translation(user_id, text):
    history = retrieve_history(user_id)
    if not history:
        db.child("user").child(user_id).set({"history": [text]})
    else:
        history = [text] + history
        db.child("user").child(user_id).update({"history": history})
