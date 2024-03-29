FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt --no-cache

COPY coinbot.py .

ARG build
ENV BUILD_SHA=$build

CMD [ "python", "-m", "coinbot" ]
