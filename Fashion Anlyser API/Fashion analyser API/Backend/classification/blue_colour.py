import cv2
import numpy as np

def blue(frame):
    lower_range=np.array([95,120,30])
    upper_range=np.array([130,255,255])

    hsv=cv2.cvtColor(frame,cv2.COLOR_BGR2HSV)
    mask=cv2.inRange(hsv,lower_range,upper_range)
    _,mask1=cv2.threshold(mask,254,255,cv2.THRESH_BINARY)
    cnts,_=cv2.findContours(mask1,cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_NONE)
    l=600
    final=None
    for c in cnts:
        if cv2.contourArea(c)>l:
            final=c
    if final is not None:
        x,y,w,h=cv2.boundingRect(final)
        cv2.rectangle(frame,(x,y),(x+w,y+h),(255,0,0),2)
        cv2.putText(frame,("DETECT"),(10,60),cv2.FONT_HERSHEY_SIMPLEX,0.6,(0,0,255),2)
    return final