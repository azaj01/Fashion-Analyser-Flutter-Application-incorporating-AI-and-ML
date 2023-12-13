import cv2,random
from math import pi

def get_value(up,low):
    if up is None:
        return handle_non_detection()
    elif low is None:
        return handle_single_detection(up)
    else:
        return outfit_match(up,low)

    
def handle_non_detection():
    return random.random()*10+60

def handle_single_detection(ob):
    with open("bounds.txt",'r') as f:
        a,b=None,None
        if ob.attr=='r':
            a,b=eval(f.readlines()[0])
        if ob.attr=='o':
            a,b=eval(f.readlines()[1])
        if ob.attr=='y':
            a,b=eval(f.readlines()[2])
        if ob.attr=='g':
            a,b=eval(f.readlines()[3])
        if ob.attr=='c':
            a,b=eval(f.readlines()[4])
        if ob.attr=='b':
            a,b=eval(f.readlines()[5])
        if ob.attr=='v':
            a,b=eval(f.readlines()[6])
        if ob.attr=='p':
            a,b=eval(f.readlines()[7])
        

        for i in range(3):
            a[i]=abs(a[i]-b[i])*6.47
            b[i]=0
        
        return resultant_percent(a,b)
        
def outfit_match(ob1,ob2):
    with open("bounds.txt",'r') as f:
        lines=f.readlines()
        a,b=None,None
        if ob1.attr=='r':
            a,b=eval(lines[0])
        if ob1.attr=='o':
            a,b=eval(lines[1])
        if ob1.attr=='y':
            a,b=eval(lines[2])
        if ob1.attr=='g':
            a,b=eval(lines[3])
        if ob1.attr=='c':
            a,b=eval(lines[4])
        if ob1.attr=='b':
            a,b=eval(lines[5])
        if ob1.attr=='v':
            a,b=eval(lines[6])
        if ob1.attr=='p':
            a,b=eval(lines[7])
        x,y=None,None
        if ob2.attr=='r':
            x,y=eval(lines[0])
        if ob2.attr=='o':
            x,y=eval(lines[1])
        if ob2.attr=='y':
            x,y=eval(lines[2])
        if ob2.attr=='g':
            x,y=eval(lines[3])
        if ob2.attr=='c':
            x,y=eval(lines[4])
        if ob2.attr=='b':
            x,y=eval(lines[5])
        if ob2.attr=='v':
            x,y=eval(lines[6])
        if ob2.attr=='p':
            x,y=eval(lines[7])
        p,q=[],[]
        for i in range(3):
            p.append(a[i]+x[i])
            q.append(b[i]+y[i])
        return resultant_percent(p,q)

def resultant_percent(x,y):
    ans=0
    for i in range(3):
        ans+=((x[i]+y[i])**.5)
    return ans