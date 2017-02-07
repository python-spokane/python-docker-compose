# use official python container from https://hub.docker.com/
FROM python:2.7.13-wheezy

# create directory inside the container
RUN mkdir /code

# sets the working directory inside the container
WORKDIR /code

# copy your local requirements.txt file into the container
COPY requirements.txt /code/

# Update and install requirements
RUN apt-get update && apt-get -qy install build-essential \
    python-dev python-pip binutils \
    --no-install-recommends && rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install -r /code/requirements.txt

# expose container ports to host system
EXPOSE 5000 5000
