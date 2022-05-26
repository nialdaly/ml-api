import time

from fastapi import FastAPI, Request

from .routers import gpt2

app = FastAPI(title="ml-api", description="ml-api", version="0.0.1")


@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    process_time = time.time() - start_time
    response.headers["X-Process-Time"] = str(process_time)
    return response


app.include_router(gpt2.router)
