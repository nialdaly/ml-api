# ml-api
A pattern for deploying machine learning models as API endpoints. This pattern utilises the following tools:
- Hugging Face
- FastAPI
- Amazon SageMaker
- Terraform

To get started, run the following commands in the project root:
```
python3 -m venv .venv
source .venv/bin/activate
pip3 install -U pip
pip3 install poetry
poetry install
```

To run the live FastAPI server, use the following command in the project root:
```
uvicorn app.main:app --reload --host 0.0.0.0 --port 8080
```
