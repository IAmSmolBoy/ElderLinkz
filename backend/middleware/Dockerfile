# FROM python:3.11.5-slim

WORKDIR /middleware

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .

CMD [ "python", "src/core.py" ]