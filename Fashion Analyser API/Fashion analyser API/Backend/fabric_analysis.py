import cv2
import numpy as np
import tensorflow as tf
import tensorflow_hub as hub


def load_model():
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
