FROM openjdk:11-jre

ENV JAVA_MAX_METASPACE_SIZE=512m \
    JAVA_OPTS= \
    JAVA_XMS=512m \
    JAVA_XMX=512m \
    ELASTIC_APM_AGENT_VERSION=1.5.0

COPY start.sh /start.sh
ADD http://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/${ELASTIC_APM_AGENT_VERSION}/elastic-apm-agent-${ELASTIC_APM_AGENT_VERSION}.jar /elastic-apm-agent.jar

ONBUILD ARG JAR_FILE=app.jar
ONBUILD COPY ${JAR_FILE} /app.jar

EXPOSE 8080
VOLUME /tmp

CMD ["/start.sh"]
