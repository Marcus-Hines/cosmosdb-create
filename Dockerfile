FROM ubuntu:latest

COPY . /action

ENTRYPOINT ["chmod", "+x", "/action/entrypoint.sh"]