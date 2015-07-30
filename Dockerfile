FROM phusion/baseimage:0.9.16

RUN apt-get update && \
    apt-get install -y \
        python \
        python-dev \
        libffi-dev \
        libpq-dev \
        libxslt1-dev \
        libxml2-dev

RUN curl https://bootstrap.pypa.io/get-pip.py | python

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY sentry.conf.py sentry.conf.py

# Clean up APT when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD sentry --config=sentry.conf.py celery worker -B & \
    sentry --config=sentry.conf.py start --upgrade

EXPOSE 8080