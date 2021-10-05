FROM ubuntu:latest

COPY . /action

ENTRYPOINT ["/action/entrypoint.sh"]