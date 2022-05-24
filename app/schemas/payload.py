from typing import Optional

from pydantic import BaseModel


class Payload(BaseModel):
    input_string: str
    response_length: Optional[int] = None
