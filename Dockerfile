FROM phusion/baseimage:0.9.15

RUN apt-get update && \
    apt-get install -y \
        python-pip \
        python-dev \
        libpq-dev

ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt

ADD sentry.conf.py sentry.conf.py

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD sentry --config=sentry.conf.py start
EXPOSE 8080