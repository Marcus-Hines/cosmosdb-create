FROM mcr.microsoft.com/azure-cli

COPY . /action

ENTRYPOINT ["/action/entrypoint.sh"]