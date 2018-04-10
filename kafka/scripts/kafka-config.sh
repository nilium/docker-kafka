#!/usr/bin/env bash

: ${KAFKA_BROKER_ID:=0}

# The following variables can be used to configure kafka in the absence of a complete LISTENERS list.
: ${KAFKA_LISTEN_PORT:=9092}
: ${KAFKA_LISTEN_PROTOCOL:=PLAINTEXT}
: ${KAFKA_ADV_PORT:=${KAFKA_LISTEN_PORT}}
: ${KAFKA_ADV_ADDR:=$(hostname -f)}

# Listeners
: ${KAFKA_LISTENERS:=${KAFKA_LISTEN_PROTOCOL}://${KAFKA_LISTEN_ADDR}:${KAFKA_LISTEN_PORT}}
: ${KAFKA_ADV_LISTENERS:=${KAFKA_PROTOCOL}://${KAFKA_ADV_ADDR}:${KAFKA_ADV_PORT}}

# Whether to automatically create topics on use
: ${KAFKA_AUTO_CREATE_TOPICS:=true}
case "$KAFKA_AUTO_CREATE_TOPICS" in
[Tt][Rr][Uu][Ee]|[Yy][Ee][Ss]|[Yy]|[Tt]|1|'')
    KAFKA_AUTO_CREATE_TOPICS=true
    ;;
*)
    KAFKA_AUTO_CREATE_TOPICS=false
    ;;
esac

# Zookeeper connection -- defaults to localhost for lack of any sane default
: ${KAFKA_ZK_CONNECT:=localhost:2181}
: ${KAFKA_ZK_TIMEOUT:=6000}

# Other variables
: ${KAFKA_COMPRESSION:=uncompressed}
: ${KAFKA_NW_THREADS:=3}
: ${KAFKA_IO_THREADS:=8}
: ${KAFKA_PARTITIONS:=8}
: ${KAFKA_SEND_BUFFER:=102400}
: ${KAFKA_RECV_BUFFER:=102400}
: ${KAFKA_SOCK_MAXBYTES:=104857600}
: ${KAFKA_RECOV_THREADS:=1}
: ${KAFKA_OFFSET_REPL_FACTOR:=1}
: ${KAFKA_TX_LOG_REPL_FACTOR:=1}
: ${KAFKA_TX_LOG_MIN_ISR:=1}
: ${KAFKA_LOG_DIR:=/data}
: ${KAFKA_LOG_FLUSH_INTERVAL_MSGS:=10000}
: ${KAFKA_LOG_FLUSH_INTERVAL_MS:=1000}
: ${KAFKA_LOG_RETENTION_HR:=168}
: ${KAFKA_LOG_RETENTION_BYTES:=1073741824}
: ${KAFKA_LOG_SEGMENT_BYTES:=1073741824}
: ${KAFKA_LOG_RETENTION_CHECK_MS:=300000}

cat <<EOF
broker.id=${KAFKA_BROKER_ID}
listeners=${KAFKA_LISTENERS}
advertised.listeners=${KAFKA_ADV_LISTENERS}
auto.create.topics.enable=${KAFKA_AUTO_CREATE_TOPICS}
compression.type=${KAFKA_COMPRESSION}
num.network.threads=${KAFKA_NW_THREADS}
num.io.threads=${KAFKA_IO_THREADS}
socket.send.buffer.bytes=${KAFKA_SEND_BUFFER}
socket.receive.buffer.bytes=${KAFKA_RECV_BUFFER}
socket.request.max.bytes=${KAFKA_SOCK_MAXBYTES}
num.partitions=${KAFKA_PARTITIONS}
num.recovery.threads.per.data.dir=${KAFKA_RECOV_THREADS}
offsets.topic.replication.factor=${KAFKA_OFFSET_REPL_FACTOR}
transaction.state.log.replication.factor=${KAFKA_TX_LOG_REPL_FACTOR}
transaction.state.log.min.isr=${KAFKA_TX_LOG_MIN_ISR}
log.dir=${KAFKA_LOG_DIR}
log.flush.interval.messages=${KAFKA_LOG_FLUSH_INTERVAL_MSGS}
log.flush.interval.ms=${KAFKA_LOG_FLUSH_INTERVAL_MS}
log.retention.hours=${KAFKA_LOG_RETENTION_HR}
log.retention.bytes=${KAFKA_LOG_RETENTION_BYTES}
log.segment.bytes=${KAFKA_LOG_SEGMENT_BYTES}
log.retention.check.interval.ms=${KAFKA_LOG_RETENTION_CHECK_MS}
zookeeper.connect=${KAFKA_ZK_CONNECT}
zookeeper.connection.timeout.ms=${KAFKA_ZK_TIMEOUT}
EOF
