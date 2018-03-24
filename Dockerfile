FROM openjdk:10-jre

ENV JAVA_MAX_METASPACE_SIZE=512m \
    JAVA_OPTS= \
    JAVA_XMS=512m \
    JAVA_XMX=512m

COPY start.sh /start.sh

ONBUILD ARG JAR_FILE=app.jar
ONBUILD COPY ${JAR_FILE} /app.jar

EXPOSE 8080
VOLUME /tmp

CMD ["/start.sh"]
