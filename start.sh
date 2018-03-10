#!/bin/sh

set -euo pipefail

echo "Xms: ${JAVA_XMS}"
echo "Xmx: ${JAVA_XMX}"
echo "JAVA_OPTS: ${JAVA_OPTS}"
echo "Arguments: $@"

exec java \
        -server \
        -XX:+UnlockExperimentalVMOptions \
        -XX:+ExitOnOutOfMemoryError \
        -XX:+UseCGroupMemoryLimitForHeap \
        -XX:MaxRAMFraction=${JAVA_MAX_RAM_FRACTION} \
        -XshowSettings:vm \
        -Xms${JAVA_XMS} \
        -Xmx${JAVA_XMX} \
        -Djava.security.egd=file:/dev/./urandom \
        ${JAVA_OPTS} \
        -jar /app.jar \
        "$@"
