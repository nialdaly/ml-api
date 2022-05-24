from fastapi import FastAPI

from .routers import gpt2

app = FastAPI(
    title="ml-api",
    description="ml-api",
    version="0.0.1",
)

app.include_router(gpt2.router)
