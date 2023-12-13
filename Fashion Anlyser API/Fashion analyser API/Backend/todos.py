from fastapi import Body, APIRouter, HTTPException, status
from pydantic_models import TodoRequest, TodoResponse
router = APIRouter(tags=["todo"])
todos = [{'title':"default","desc":"default desc"}]
# create todo


@router.post('/api/v1/todos')
def createTodo(todo: TodoRequest = Body(...)):
    todos.append(todo)
    print(todo)
    return {"todo got created"}

# get all todos


@router.get('/api/v1/todos')
def getAllTodos():
    return todos

# get a todo by title


@router.get('/api/v1/todos/{title}', response_model=TodoResponse)
def getTodoByTitle(title: str):
    response = None
    for todo in todos:
        print(todo)
        if todo['title'] == title:
            response = {"status": "200", "message": "todo found", "data": todo}
            break
    if response:
        return response
    else:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "todo not found")

# update a todo by title

# delete a todo by title


@router.delete('/api/v1/todos/{title}')
def getTodoByTitle(title: str):
    response = {"status": 404,
                "message": "todo not found to delete", "data": {}}
    for todo_idx, todo in enumerate(todos):
        if todo['title'] == title:
            todos.pop(todo_idx)
            response = {"status": 200, "message": "todo deleted", "data": todo}
            break
    return response
