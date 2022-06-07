# SIGNify

## Purpose:

This app is an interface where deaf and non-deaf people can easily understand sign language through a graphical context.

## Usage & Current Functionality:

To use the application is simple - they have to point the camera to the sign language speaker, and the application will output the text in real time. As a mobile application, users will be able to translate sign language anytime anywhere.

### Home Page

The flutter app has three options for the user on the home page (Login, Register, and Continue as Guest). If the user would like to save and view their history, they would need to authenticated with the application.

### Login and Register

Users can simply use their email and password to register an account. In the backend, a new firebase user will be created using that information.
When the user logs in with their credentials, the app will receive an unique userid that can be used to retrive relevant information from the backend.

### Camera Page

This page allows to record and convert sign language displayed by a person into text that the user can read in real time. The square box will change color to provide feedback based on the confidence score and display helpful messages like "Keep Steady for accurate results".

### Settings Page

Here users are able to customize different options for theme, color, and font-size. They can also perform login/logout actions from settings.

## API Documentation

If testing on deployed website then:

```
Base URL = https://signify-10529.uc.r.appspot.com/
```

Otherwise, if testing on localhost then:

```
Base URL = http://localhost:5000
```

The base URL will precede all the routes listed below.

### Routes

```
POST /login

Purpose: Logging in a user

Expected Type: raw JSON

Expected Data: {
    "username": "user"
    "password": "user"
}

Returns: {
    "id": "uniqueId" (this is firebase userId)
}
```

```
POST /register

Purpose: Creating a new user

Expected Type: raw JSON

Expected Data: {
    "username": "user"
    "password": "user"
}

Returns: {
    "result": "true/false"
}
```

```
GET /

Purpose: Create integration tests for API


Expected Data: None

Returns: "Hello, welcome to the api endpoint for SIGNify!"
```

```
POST /upload_video

Purpose: Allows video upload for converting sign language into text

Expected Type: raw JSON + file upload

Expected Data: {
    "username": "user",
    "video": "filename"
}

Returns: {
    "word": "text"
}
```

### Install dependencies and run on your local machine

Emulators, Flutter and Python should be installed on your machine.
Clone the project onto your local machine.

```bash=1
git clone https://github.com/GDSCUTM-CommunityProjects/SIGNify
```

Install all the python packages and start backend server. Go into the backend folder and install all pip packages:

```bash=2
cd backend
pip install -r requirements.txt
cd ../
```

To install all the Flutter dependencies and run the flutter application:

```bash=7
cd frontend
flutter pub get
flutter run
```

The application runs on Andriod/iOS emulator on your local machine. The server runs on **localhost:5000** on your local machine.
