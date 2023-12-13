import cv2

def detect_upper_lower(obs):
    ob1,ob2=get_two_max(obs)
    if ob1 is None:
        return None,None
    if ob1 is not None and ob2 is not None:
        x1,y1,w1,h1=cv2.boundingRect(ob1.frame)
        x2,y2,w2,h2=cv2.boundingRect(ob2.frame)
        if y1<y2:
            return ob1,ob2
        else:
            return ob2,ob1
    else:
        return ob1,None
def get_two_max(obs):
    mx,smx=None,None
    for ob in obs:
        if ob.frame is not None:
            if mx is None or cv2.contourArea(ob.frame)>cv2.contourArea(mx.frame):
                smx=mx
                mx=ob
            elif smx is None or cv2.contourArea(ob.frame)>cv2.contourArea(smx.frame):
                smx=ob
    return mx,smx
