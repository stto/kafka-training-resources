#!/usr/bin/env bash
KAFKA_VERSION="2.13-3.1.0"
wget "https://downloads.apache.org/kafka/3.1.0/kafka_${KAFKA_VERSION}.tgz"
tar xfz kafka_${KAFKA_VERSION}.tgz
rm kafka_${KAFKA_VERSION}.tgz
mv kafka_${KAFKA_VERSION} ~/kafka
export PATH=~/kafka/bin:"$PATH"
echo "export PATH=~/kafka/bin:$PATH" >> ~/.bashrcuser@user-163-10-kafka-vm:~/training$ cat test-connection.sh 
#!/usr/bin/env bash
echo "Testing Zookeeper…"
echo -n "ZK 1"
zookeeper-shell.sh localhost:2181 ls / > /dev/null 2>&1 || echo -ne "\t !!! Not"
echo -e "\tOK"
echo -n "ZK 2"
zookeeper-shell.sh localhost:2182 ls / > /dev/null 2>&1 || echo -ne "\t !!! Not"
echo -e "\tOK"
echo -n "ZK 3"
zookeeper-shell.sh localhost:2183 ls / > /dev/null 2>&1 || echo -ne "\t !!! Not"
echo -e "\tOK"
echo "Testing Kafka…"
echo -n "Kafka 1"
kafka-broker-api-versions.sh --bootstrap-server localhost:9092 > /dev/null 2>&1 || echo -ne "\t !!! Not"
echo -e "\tOK"
echo -n "Kafka 2"
kafka-broker-api-versions.sh --bootstrap-server localhost:9093 > /dev/null 2>&1 || echo -ne "\t !!! Not"
echo -e "\tOK"
echo -n "Kafka 3"
kafka-broker-api-versions.sh --bootstrap-server localhost:9094 > /dev/null 2>&1 || echo -ne "\t !!! Not"
echo -e "\tOK"
echo "Happy Hacking!"
