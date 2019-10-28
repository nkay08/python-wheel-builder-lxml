###########
# BUILDER #
###########

# pull official base image
FROM python:3.8.0-alpine as builder

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# lint
RUN pip install --upgrade pip
RUN pip install flake8
COPY . /usr/src/app/
#RUN flake8 --ignore=E501,F401 .

RUN apk add libxml2-dev libxslt-dev

RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels lxml
