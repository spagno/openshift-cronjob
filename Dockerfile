FROM alpine
COPY start.sh /usr/bin/start.sh
ENV ARGS
CMD start.sh
