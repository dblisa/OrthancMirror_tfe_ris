from getpass import getpass

from database.postgres_db import authenticate_user


username = input("Username: ")
password = getpass("Password: ")

user = authenticate_user(username, password)

if user:
    print("Authentication successful!")
    print("Username:", user["username"])
    print("Role:", user["role"])
else:
    print("Invalid username or password")