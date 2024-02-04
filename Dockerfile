FROM python:latest

ENV API_KEY ""
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8
LABEL authors="tomer.klein@gmail.com"

RUN apt -yqq update && \
    apt -yqq install gnupg2 ffmpeg && \
    apt -yqq install curl unzip && \
    rm -rf /var/lib/apt/lists/*
    
RUN pip3 install --upgrade pip --no-cache-dir && \
    pip3 install --upgrade setuptools --no-cache-dir

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt

RUN mkdir -p /app/downloads
RUN mkdir /root/.spotdl

RUN chmod 1777 /root/.spotdl
RUN chmod 1777 /app/downloads

WORKDIR /app

CMD spotdl web --host 0.0.0.0 --keep-alive --web-use-output-dir --output /app/downloads
