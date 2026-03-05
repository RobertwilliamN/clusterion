from fastapi import FastAPI
from app.routes import health, bootstrap
from app.core.config import settings

app = FastAPI(title=settings.APP_NAME)

app.include_router(health.router)
app.include_router(bootstrap.router)