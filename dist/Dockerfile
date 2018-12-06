FROM glassfish:latest

MAINTAINER Baptiste Perreaux "baptiste.perreaux@efrei.net"

COPY start.sh /
COPY projet.war /

EXPOSE 8080 4848 8181

ENTRYPOINT ["/start.sh"]
