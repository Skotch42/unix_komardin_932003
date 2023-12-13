FROM ubuntu:latest

COPY script.sh /script.sh

RUN chmod +x /script.sh

RUN apt-get update

VOLUME /my_volume

CMD ["/script.sh"]
