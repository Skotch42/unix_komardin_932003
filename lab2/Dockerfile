FROM ubuntu:latest

COPY script.sh /script.sh

RUN chmod +x /script.sh

RUN apt-get update && apt-get install -y bash

CMD ["/script.sh"]
