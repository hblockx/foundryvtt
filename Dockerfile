FROM alpine:latest
MAINTAINER fithwum

ARG INSTALL_SCRIPT=https://raw.githubusercontent.com/hblockx/foundryvtt/master/files/Install_Script.sh

ENV PUID=99
ENV GUID=100

RUN adduser -D -u 99 -G users -h /foundry -s /bin/bash foundry

#RUN addgroup -S 100 \
#	&& adduser -S -u 99 -D foundry -G 100

# Install dependencies and folder creation
RUN apk update && apk add --no-cache ca-certificates libstdc++ su-exec bash-completion tar nodejs npm \
	&& mkdir -p /foundry /ftemp \
	&& chmod 777 -R /foundry \
	&& chown 99:100 -R /foundry

ADD "${INSTALL_SCRIPT}" /ftemp
RUN chmod +x /ftemp/Install_Script.sh \
	&& chown 99:100 -R /ftemp/Install_Script.sh

# USER foundry

# directory where data is stored
VOLUME /foundry

# TCP Port
EXPOSE 30000

# Run command
CMD [ "/bin/sh", "/ftemp/Install_Script.sh" ]
