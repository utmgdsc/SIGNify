import cv2

def translate():
    images = convert_video_to_image()
    return {"text": "hello"}

def convert_video_to_image():
    video = cv2.VideoCapture(".\\video\\temp.mp4")
    images = []
    sec = 0.5
    frame_rate = 0.5
    video.set(cv2.CAP_PROP_POS_MSEC, sec * 1000)
    success, image = video.read()
    while success:
        images.append(image)
        #cv2.imwrite(".\\video\\image" + str(sec * 2) + ".jpg", image)
        sec = sec + frame_rate
        video.set(cv2.CAP_PROP_POS_MSEC, sec * 1000)
        success, image = video.read()
    return images