#!/bin/sh

set -euo pipefail

echo "Xms: ${JAVA_XMS}"
echo "Xmx: ${JAVA_XMX}"
echo "MaxMetaspaceSize: ${JAVA_MAX_METASPACE_SIZE}"
echo "JAVA_OPTS: ${JAVA_OPTS}"
echo "Arguments: $@"

COMMON_JAVA_OPTS="-server
  -XX:+ExitOnOutOfMemoryError
  -XX:+UnlockExperimentalVMOptions
  -XX:+UseCGroupMemoryLimitForHeap
  -XshowSettings:vm
  -Djava.security.egd=file:/dev/./urandom"

if [ -n "$JAVA_MAX_METASPACE_SIZE" ]; then
  COMMON_JAVA_OPTS="$COMMON_JAVA_OPTS -XX:MaxMetaspaceSize=${JAVA_MAX_METASPACE_SIZE}"
fi

if [ -n "$JAVA_MAX_RAM_FRACTION" ]; then
  COMMON_JAVA_OPTS="$COMMON_JAVA_OPTS -XX:MaxRAMFraction=${JAVA_MAX_RAM_FRACTION}"
fi

if [ -n "$JAVA_XMS" ]; then
  COMMON_JAVA_OPTS="$COMMON_JAVA_OPTS -Xms${JAVA_XMS}"
fi

if [ -n "$JAVA_XMX" ]; then
  COMMON_JAVA_OPTS="$COMMON_JAVA_OPTS -Xmx${JAVA_XMX}"
fi

exec java \
  ${COMMON_JAVA_OPTS} \
  ${JAVA_OPTS} \
  -jar /app.jar \
  "$@"
