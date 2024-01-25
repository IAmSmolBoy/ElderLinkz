FROM python:3.11.5-slim

WORKDIR /test

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./ simulation

CMD [ "python", "simulation.py" ]