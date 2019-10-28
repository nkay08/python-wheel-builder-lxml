# python-wheel-builder-lxml

Image that builds wheel for lxml and possibly other modules

Extend the image with: 
```
FROM nkay08/python-wheel-builder-lxml/
COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt
```

In the same Dockerfile you can then add your actual image that doesnt need build dependencies, e.g.:
```
#########
# FINAL #
#########

# pull official base image
FROM python:3.8.0-alpine
# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN addgroup -S app && adduser -S app -G app

# create the home directory
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# install dependencies
RUN apk update && apk add libpq gettext
COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.txt .
RUN pip install --no-cache /wheels/*
```
```
...
```
