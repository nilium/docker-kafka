#!/bin/sh
: ${KAFKA_SERVER_CONFIG:="${KAFKA_HOME}/config/server.properties"}
if ! [ -e "$KAFKA_SERVER_CONFIG" ]; then
  kafka-config.sh > "$KAFKA_HOME/config/server.properties"
fi
# Run Kafka
exec "$KAFKA_HOME/bin/kafka-server-start.sh" "$KAFKA_SERVER_CONFIG"
