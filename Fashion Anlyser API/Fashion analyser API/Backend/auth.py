from fastapi import Body, APIRouter, HTTPException, status
router = APIRouter(tags=["auth"])
user_coll = [{"username": "admin1", "password": "admin123"},
             {"username": "admin2", "password": "admin456"}]


@router.post('/api/v1/auth/users')
def signup(user_data: dict = Body(...)):
    for user_obj in user_coll:
        if user_obj['username'] == user_data['username']:
            # user exists throw error
            raise HTTPException("user already signed up!")
    user_coll.append(user_data)
    return {'user signedup successfully!'}


@router.get('/api/v1/auth/users')
def getAllUsers():
    return user_coll
