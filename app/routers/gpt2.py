from fastapi import APIRouter

from app.schemas import payload

from ..models.gpt2_endpoint import invoke_endpoint

router: APIRouter = APIRouter(tags=["gpt2"])


@router.post("/v1/models/gpt2/")
async def gpt2_response(payload: payload.Payload) -> str:
    return invoke_endpoint(payload.input_string, payload.response_length)
