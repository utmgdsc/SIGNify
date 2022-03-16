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


def store_translation(user_id, translation):
    history = retrieve_history(user_id)
    if not history:
        db.child("user").child(user_id).set({"history": [translation]})
    else:
        history = [translation] + history
        db.child("user").child(user_id).update({"history": history})