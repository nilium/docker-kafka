# Fetch Kafka
FROM alpine AS fetch

ARG SCALA_VERSION="2.11"
ARG KAFKA_VERSION="0.11.0.2"
ARG KAFKA_SHA512="0169ded7e551476ff3f1ce70d76c518d31116acc1ae43b15e89bea4b072fa8727239e51e84c2306dfd668efffc26dbc83c9598acbd355c283f650c64c4788188"

COPY mirrors.txt /tmp/mirrors.txt
RUN apk add --no-cache curl ca-certificates tar

WORKDIR /tmp
RUN curl -v --fail -Lo /tmp/kafka.tgz -g "$(shuf -n1 /tmp/mirrors.txt)/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
RUN echo "${KAFKA_SHA512}  kafka.tgz" | sha512sum -c
RUN mkdir -p /opt/kafka
RUN tar --strip-components=1 -xzf /tmp/kafka.tgz -C /opt/kafka
RUN rm /opt/kafka/config/server.properties

# Build runtime environment
FROM java:openjdk-8-jre

ENV KAFKA_HOME /opt/kafka
EXPOSE 9092
VOLUME ["/data"]

COPY --from=fetch /opt/kafka /opt/kafka
COPY scripts /usr/local/bin

ENTRYPOINT ["/usr/local/bin/start-kafka.sh"]
