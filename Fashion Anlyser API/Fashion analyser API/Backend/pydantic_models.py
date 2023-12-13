from pydantic import BaseModel


class TodoRequest(BaseModel):
    title: str
    desc: str


class TodoResponse(BaseModel):
    status: str
    message: str
    data: dict
