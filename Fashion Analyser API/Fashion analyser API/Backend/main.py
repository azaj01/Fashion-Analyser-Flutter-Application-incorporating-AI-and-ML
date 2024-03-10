import os

import classification.blue_colour as blue_colour
import classification.cyan_colour as cyan_colour
import classification.green_colour as green_colour
import classification.orange_colour as orange_colour
import classification.pink_colour as pink_colour
import classification.red_colour as red_colour
import classification.violet_colour as violet_colour
import classification.yellow_colour as yellow_colour
import cv2
import fabric_analysis
import numpy as np
import result
import segment
import tensorflow as tf
import tensorflow_hub as hub
from fastapi import BackgroundTasks, Body, FastAPI

# from Backend.fabric_analysis import analyze_fabric_quality

# Import your color classification and other modules here


class Node:
    def __init__(self, frame, attr):
        self.frame = frame
        self.attr = attr


app = FastAPI()

global cap
cap = None

# @app.on_event("startup")


def startup_event():
    global cap
    cap = cv2.VideoCapture(0)


def shutdown_event():
    global cap
    if cap is not None:
        cap.release()
        cv2.destroyAllWindows()


@app.get("/")
async def process_frames():
    ans1 = analyze_fabric_quality()
    startup_event()

    while True:
        ret, frame = cap.read()
        frame = cv2.resize(frame, (640, 480))
        obs = [
            Node(red_colour.red(frame), 'r'),
            Node(green_colour.green(frame), 'g'),
            Node(blue_colour.blue(frame), 'b'),
            Node(pink_colour.pink(frame), 'p'),
            Node(orange_colour.orange(frame), 'o'),
            Node(yellow_colour.yellow(frame), 'y'),
            Node(violet_colour.violet(frame), 'v'),
            Node(cyan_colour.cyan(frame), 'c')
        ]

        upper, lower = segment.detect_upper_lower(obs)
        ans = result.get_value(upper, lower)
        print(round(ans, 2))
        shutdown_event()

        return [round(ans, 2), ans1]

        cv2.imshow("FRAME", frame)
        if cv2.waitKey(1) & 0xFF == 27:
            break


async def release_resources(background_tasks: BackgroundTasks):
    global cap
    background_tasks.add_task(shutdown_event)


def load_model():
    # Set TFHUB_CACHE_DIR to a writable directory
    os.environ["TFHUB_CACHE_DIR"] = "/path/to/cache/directory"

    model_url = "https://tfhub.dev/google/tf2-preview/mobilenet_v2/classification/4"
    model = tf.keras.Sequential([
        hub.KerasLayer(model_url, input_shape=(224, 224, 3))
    ])
    return model


def preprocess_image(frame):
    frame = cv2.resize(frame, (224, 224))
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    frame = frame / 255.0  # Normalize to [0, 1]
    return np.expand_dims(frame, axis=0)


def detect_fabric_quality(model, frame):
    preprocessed_frame = preprocess_image(frame)
    predictions = model.predict(preprocessed_frame)
    predicted_label = np.argmax(predictions[0])

    # Map the predicted label to the desired numeric range (1 to 10)
    numeric_quality = int(np.interp(predicted_label, [0, 1000], [1, 10]))

    return numeric_quality


def analyze_fabric_quality():
    global cap  # Mark cap as global
    # Load pre-trained MobileNetV2 model
    fabric_quality_model = load_model()

    # Open the system camera (default camera index is 0)
    cap = cv2.VideoCapture(0)

    # Capture a single frame
    ret, frame = cap.read()

    if ret:
        # Perform fabric quality analysis on the frame
        numeric_quality = detect_fabric_quality(fabric_quality_model, frame)

        # Release the camera and close all windows
        cap.release()
        cv2.destroyAllWindows()

        return numeric_quality
    else:
        print("Error capturing the frame.")
        return None
