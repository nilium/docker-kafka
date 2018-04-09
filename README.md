Kafka in Docker
===

This is a fork of Spotify's Kafka in Docker container. Unlike Spotify's, it does
not include Zookeeper in-container, as this is intended for testing use in
Kubernetes (where it's relatively easy to bring up a separate Zookeeper pod and
services).

The kafkaproxy has been removed from this fork. You should use Spotify's
container or repository for that.

Why?
---
There are no library Docker images for Kafka and I trust Spotify more than most
random Docker Hub users to have a usable base.

Run
---

```bash
docker run -p 127.0.0.1:9092:9092 \
  -e KAFKA_ADV_ADDR=localhost \
  -e KAFKA_ZK_CONNECT=zookeeper:2181 \
  spiffastic/kafka
```

Environment Variables
---

- `KAFKA_BROKER_ID = 0`  
    The broker ID.

The following variables can be used to configure kafka in the absence of
a complete listeners list.

- `KAFKA_ADDR = ''`
- `KAFKA_PORT = 9092`
- `KAFKA_PROTOCOL = PLAINTEXT`
- `KAFKA_ADV_PROTOCOL = ${KAFKA_PROTOCOL}`
- `KAFKA_ADV_ADDR = $(hostname -f)`
- `KAFKA_ADV_PORT = ${KAFKA_PORT}`

Otherwise, you can set the following variables yourself and not generate them
from the above few.

- `KAFKA_LISTENERS = ${KAFKA_PROTOCOL}://${KAFKA_ADDR}:${KAFKA_PORT}`  
- `KAFKA_ADV_LISTENERS = ${KAFKA_PROTOCOL}://${KAFKA_ADV_ADDR}:${KAFKA_ADV_PORT}`

- `KAFKA_AUTO_CREATE_TOPICS = true`  
    Whether to automatically create topics upon use. (`true` or `false`)

The following variables control the Zookeeper connection:

- `KAFKA_ZK_CONNECT = localhost:2181`  
	KAFKA_ZK_CONNECT accepts a comma-separated list of Zookeeper addresses to
	connect to.
- `KAFKA_ZK_TIMEOUT = 6000`

And additional variables to tweak the generated server.properties:

- `KAFKA_COMPRESSION = uncompressed`
- `KAFKA_NW_THREADS = 3`
- `KAFKA_IO_THREADS = 8`
- `KAFKA_PARTITIONS = 8`
- `KAFKA_SEND_BUFFER = 102400`
- `KAFKA_RECV_BUFFER = 102400`
- `KAFKA_SOCK_MAXBYTES = 104857600`
- `KAFKA_RECOV_THREADS = 1`
- `KAFKA_OFFSET_REPL_FACTOR = 1`
- `KAFKA_TX_LOG_REPL_FACTOR = 1`
- `KAFKA_TX_LOG_MIN_ISR = 1`
- `KAFKA_LOG_DIR = /data`
- `KAFKA_LOG_FLUSH_INTERVAL_MSGS = 10000`
- `KAFKA_LOG_FLUSH_INTERVAL_MS = 1000`
- `KAFKA_LOG_RETENTION_HR = 168`
- `KAFKA_LOG_RETENTION_BYTES = 1073741824`
- `KAFKA_LOG_SEGMENT_BYTES = 1073741824`
- `KAFKA_LOG_RETENTION_CHECK_MS = 300000`

If you provide a server.properties in the container (by bind mounting one, such
as with a ConfigMap in Kubernetes), these variables have no effect.

In the box
---
* **spiffastic/kafka**

  A docker image containing Kafka.

Public Builds
---

https://registry.hub.docker.com/u/spiffastic/kafka/

Build from Source
---

```bash
docker build -t spifftastic/kafka kafka
```

Todo
---

* Not particularily optimzed for startup time.
* Better docs
* TODO that's relevant to this image instead of its source repository.

