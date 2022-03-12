import cv2

def translate():
    """
        Function to send video to ML model and receive translation
    """
    # Convert video to frame images
    images = convert_video_to_image()
    return {"text": "hello"}

def convert_video_to_image():
    """
        Function to convert video to frame images
    """
    # Open video file
    video = cv2.VideoCapture(".\\video\\temp.mp4")
    images = []
    sec = 0.5
    # Create images every 0.5 second
    frame_rate = 0.5
    # Set video to a curtain time
    video.set(cv2.CAP_PROP_POS_MSEC, sec * 1000)
    # Create a image and check result
    success, image = video.read()
    # While loop to convert video to a series of images
    while success:
        images.append(image)
        #cv2.imwrite(".\\video\\image" + str(sec * 2) + ".jpg", image)
        sec = sec + frame_rate
        video.set(cv2.CAP_PROP_POS_MSEC, sec * 1000)
        success, image = video.read()
    return images