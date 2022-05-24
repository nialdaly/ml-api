import ast
import json
from typing import Union

import boto3

sagemaker_runtime_client = boto3.client("sagemaker-runtime")

ENDPOINT_NAME = "gpt2-sagemaker-endpoint"


def invoke_gpt2(input_string: str, response_length: Union[int, None]) -> str:
    try:
        payload: dict = {"inputs": input_string}

        if response_length is not None:
            payload["parameters"] = {"max_length": response_length}

        endpoint_response: list = sagemaker_runtime_client.invoke_endpoint(
            EndpointName=ENDPOINT_NAME,
            ContentType="application/json",
            Accept="application/json",
            Body=json.dumps(payload),
        )
        parsed_response: str = ast.literal_eval(
            endpoint_response["Body"].read().decode("utf-8")
        )[0]
        return parsed_response["generated_text"]
    except Exception:
        return "An unknown error has occurred."
