FROM python:3

ENV PYTHONBUFFERED=1

RUN mkdir /app
COPY . /app/
WORKDIR /app

COPY requirements.txt /app/

RUN pip install -r requirements.txt

RUN mkdir -p /vol/api

RUN adduser --disabled-login user
RUN chown -R user:user /vol
RUN chown -R 755 /vol/api
USER user


CMD gunicorn backend.wsgi:application --bind 0.0.0.0:8000
