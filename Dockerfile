FROM phusion/baseimage:0.9.15

RUN apt-get update && \
    apt-get install -y \
        python-pip \
        python-dev \
        libxml2-dev \
        libxslt1-dev \
        libffi-dev \
        python \
        libpq-dev

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY sentry.conf.py sentry.conf.py

# Clean up APT when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD sentry --config=sentry.conf.py upgrade && \
    sentry --config=sentry.conf.py start

EXPOSE 8080