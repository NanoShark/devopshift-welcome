from dataclasses import dataclass
from fastapi import FastAPI
import httpx
import logging



app = FastAPI()
 

# @dataclass
# class User:
#     name: str
#     email: str


# @app.get("/")
# def hello_world():
#     "This is our main function"
#     return {"result": ["Hello World", 1, 2, True, None], "error": False}


# @app.get("/users")
# def get_users() -> list[User]:
#     response = httpx.get("https://jsonplaceholder.typicode.com/users")
#     users = response.json()
#     return users


# @app.post("/users")
# def create_user(new_user: User) -> bool:
#     return True

from dataclasses import dataclass
from fastapi import FastAPI

app = FastAPI()

servers = {"nginx": True, "docker": False}


@dataclass
class ServerStatusResponse:
    server_name: str
    server_status: str | bool


@app.get("/server")
def get_server(server_name: str) -> ServerStatusResponse:
    server_status = servers.get(server_name, "Does not exist")
    return ServerStatusResponse(server_name, server_status)


@app.post("/server")
def create_server(server_name: str) -> ServerStatusResponse:
    if server_name in servers:
        return ServerStatusResponse(server_name, "Name already exists")
    else:
        servers[server_name] = True
        return ServerStatusResponse(server_name, "Created")

# logger = logging.getLogger("myapp")
# servers = {"nginX": True, "DoCkEr": False}


# def get_server_status_2(server_name: str) -> bool:
#     lowercase_servers = {key.strip().lower(): value for key, value in servers.items()}
#     if server_name in lowercase_servers:
#         return lowercase_servers[server_name]
#     else:
#         logger.error(f"The server name {server_name} does not exist")


# def get_server_status(server_name: str) -> bool:
#     lowercase_servers = {key.strip().lower(): value for key, value in servers.items()}
#     try:
#         return lowercase_servers[server_name]
#     except KeyError:
#         logger.error(f"The server name {server_name} does not exist")


# def check_servers_from_terminal():
#     while True:
#         server_name = input("Enter server name: ").strip().lower()
#         status = get_server_status(server_name)
#         logger.info(f"Server {server_name} status is: {status}")
        