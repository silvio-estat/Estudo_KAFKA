#!/bin/bash
# Script de inicialização para Kafka

# Configurações do ZooKeeper
export KAFKA_ZOOKEEPER_PROPERTIES="dataDir=/data/zookeeper"

# Configurações do Kafka
export KAFKA_DATA_DIR="/data/kafka"
export KAFKA_LISTENERS="PLAINTEXT://:9092"
export KAFKA_ADVERTISED_LISTENERS="PLAINTEXT://localhost:9092"
export KAFKA_LOG_DIRS="/data/kafka/logs"

echo "=========================================="
echo "  Iniciando ZooKeeper..."
echo "=========================================="

# Iniciar ZooKeeper em background
$KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper.properties

# Aguardar ZooKeeper iniciar
echo "Aguardando ZooKeeper iniciar..."
sleep 10

echo "=========================================="
echo "  Iniciando Kafka Broker..."
echo "=========================================="

# Iniciar Kafka em foreground (mantém o container ativo)
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
