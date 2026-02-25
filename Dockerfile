# Dockerfile para ambiente de curso de Kafka
# Base: Ubuntu 22.04 LTS
# Java: OpenJDK 17
# Kafka: 3.7.0

FROM ubuntu:22.04

# Evitar interação durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Variáveis de versão
ENV KAFKA_VERSION=3.7.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Atualizar sistema e instalar dependências
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        openjdk-17-jdk \
        wget \
        curl \
        net-tools \
        mlocate \
        iputils-ping \
        vim \
        unzip \
        && rm -rf /var/lib/apt/lists/*

# Criar diretório para Kafka
RUN mkdir -p ${KAFKA_HOME}

# Download e extrair Kafka
RUN cd /tmp && \
    wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C ${KAFKA_HOME} --strip-components=1 && \
    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Criar diretórios para dados do Kafka e ZooKeeper
RUN mkdir -p /data/kafka /data/zookeeper

# Copiar scripts de inicialização
COPY start-kafka.sh /usr/local/bin/start-kafka.sh
RUN chmod +x /usr/local/bin/start-kafka.sh

# Expor portas do ZooKeeper e Kafka
EXPOSE 2181 9092

# Definir variáveis de ambiente
ENV PATH=${KAFKA_HOME}/bin:${PATH}

# Script de inicialização padrão
CMD ["/usr/local/bin/start-kafka.sh"]
