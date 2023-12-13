import cv2
import numpy as np
from sklearn.cluster import KMeans


def get_dominant_color(img, k=1):
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img = img.reshape((img.shape[0] * img.shape[1], 3))

    kmeans = KMeans(n_clusters=k)
    kmeans.fit(img)

    dominant_color = kmeans.cluster_centers_.astype(int)[0]
    return tuple(dominant_color)


def suggest_accessory_color_name(clothing_color):
    color_mapping = {
        (255, 0, 0): 'Red',
        (0, 255, 0): 'Green',
        (0, 0, 255): 'Blue',
        (255, 255, 0): 'Yellow',
        (255, 0, 255): 'Magenta',
        (0, 255, 255): 'Cyan',
        (128, 0, 0): 'Maroon',
        (0, 128, 0): 'Olive',
        (0, 0, 128): 'Navy',
        (128, 128, 0): 'Olive Drab',
        (128, 0, 128): 'Purple',
        (0, 128, 128): 'Teal',
        # Add more color mappings as needed
    }

    return color_mapping.get(clothing_color, 'Unknown')


# Open the system camera (default camera index is 0)
cap = cv2.VideoCapture(0)

while True:
    # Capture a single frame from the camera
    ret, frame = cap.read()

    if not ret:
        break

    # Perform k-means clustering to get dominant color
    dominant_color = get_dominant_color(frame)

    # Suggest accessory color name
    accessory_color_name = suggest_accessory_color_name(dominant_color)

    # Display the original frame
    cv2.imshow('Camera Feed', frame)

    # Display the dominant color and suggested accessory color name
    color_label = f'Dominant Color: {dominant_color}, Accessory Color: {accessory_color_name}'
    cv2.putText(frame, color_label, (10, 30),
                cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)
    cv2.imshow('Color Analysis', frame)

    # Break the loop when 'q' key is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the camera and close all windows
cap.release()
cv2.destroyAllWindows()
