from fastapi import APIRouter

from app.schemas import payload

from ..models.gpt2 import invoke_gpt2

router = APIRouter(tags=["gpt2"])


@router.post("/v1/models/gpt2/")
async def model_response(payload: payload.Payload) -> str:
    return invoke_gpt2(payload.input_string, payload.response_length)
