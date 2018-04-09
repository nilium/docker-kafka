#!/bin/sh
if ! [ -e "$KAFKA_HOME/config/server.properties" ]; then
  kafka-config.sh > "$KAFKA_HOME/config/server.properties"
fi
# Run Kafka
exec "$KAFKA_HOME/bin/kafka-server-start.sh" "$KAFKA_HOME/config/server.properties"
