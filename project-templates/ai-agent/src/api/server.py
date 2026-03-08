from fastapi import FastAPI
from src.api.routes import router
from src.utils.logging import setup_logging

setup_logging()

app = FastAPI(title="ai-agent")
app.include_router(router)
