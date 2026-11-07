
import os
import time

from fastapi import FastAPI, Form, Request, Response
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from itsdangerous import URLSafeTimedSerializer, BadSignature, SignatureExpired
from psycopg.errors import UniqueViolation

from database.postgres_db import authenticate_user, create_user


app = FastAPI()
templates = Jinja2Templates(directory="auth/templates")

SESSION_SECRET = os.environ["SESSION_SECRET"]
serializer = URLSafeTimedSerializer(SESSION_SECRET, salt="ris-session")

SESSION_MAX_AGE = 8 * 60 * 60
COOKIE_NAME = "ris_session"


def get_session_user(request: Request):
    token = request.cookies.get(COOKIE_NAME)

    if not token:
        return None

    try:
        data = serializer.loads(token, max_age=SESSION_MAX_AGE)
    except (BadSignature, SignatureExpired):
        return None

    if not isinstance(data, dict):
        return None

    username = data.get("username")

    if not isinstance(username, str) or not username:
        return None

    return username


@app.get("/auth")
def verify_auth(request: Request):
    username = get_session_user(request)

    if username is None:
        return Response(status_code=401)

    return Response(
        status_code=200,
        headers={"X-RIS-User": username}
    )


@app.get("/login", response_class=HTMLResponse)
def login_page(request: Request):
    if get_session_user(request):
        return RedirectResponse(url="/", status_code=303)

    return templates.TemplateResponse(
        request=request,
        name="login.html",
        context={}
    )



 
@app.post("/login")
def login(
    request: Request,
    username: str = Form(...),
    password: str = Form(...)
):
    user = authenticate_user(username, password)

    if user is None:
        return templates.TemplateResponse(
            request=request,
            name="login.html",
            context={"error": "Identifiants incorrects"},
            status_code=401
        )

    token = serializer.dumps({
        "username": user["username"],
        "created_at": int(time.time())
    })

    response = RedirectResponse(
        url="/",
        status_code=303
    )

    response.set_cookie(
        key=COOKIE_NAME,
        value=token,
        httponly=True,
        secure=False,  # Développement local HTTP uniquement
        samesite="lax",
        max_age=SESSION_MAX_AGE,
        path="/"
    )

    return response


@app.get("/register", response_class=HTMLResponse)
def register_page(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="register.html",
        context={}
    )


@app.post("/register")
def register(
    request: Request,
    username: str = Form(...),
    email: str = Form(...),
    password: str = Form(...),
    confirm_password: str = Form(...)
):
    if password != confirm_password:
        return templates.TemplateResponse(
            request=request,
            name="register.html",
            context={"error": "Les mots de passe ne correspondent pas"},
            status_code=400
        )

    try:
        create_user(username, email, password)

    except UniqueViolation:
        return templates.TemplateResponse(
            request=request,
            name="register.html",
            context={
                "error": "Nom d'utilisateur ou email déjà utilisé"
            },
            status_code=409
        )

    except ValueError as exc:
        return templates.TemplateResponse(
            request=request,
            name="register.html",
            context={"error": str(exc)},
            status_code=400
        )

    return RedirectResponse(
        url="/login",
        status_code=303
    )


@app.get("/logout")
def logout():
    response = RedirectResponse(
        url="/login",
        status_code=303
    )

    response.delete_cookie(
        key=COOKIE_NAME,
        path="/"
    )

    return response
