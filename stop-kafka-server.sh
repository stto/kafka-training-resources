#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

zookeeper-server-stop.sh "$DIR"/config/zk1.properties
zookeeper-server-stop.sh "$DIR"/config/zk2.properties
zookeeper-server-stop.sh "$DIR"/config/zk3.properties
echo "Zookeeper stopped."
kafka-server-stop.sh "$DIR"/config/kafka1.properties
kafka-server-stop.sh "$DIR"/config/kafka2.properties
kafka-server-stop.sh "$DIR"/config/kafka3.properties
echo "Kafka stopped."user@user-163-10-kafka-vm:~/training$ cat stop-kafka-server.sh 
#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BROKER_ID="$1"

if [ -z "$BROKER_ID" ]; then
  echo "usage ./stop-kafka-server.sh [BROKER-ID]"
  exit 1
fi

PIDS=$(ps ax | grep -i 'kafka\.Kafka' | grep java | grep "kafka${BROKER_ID}.properties" | grep -v grep | awk '{print $1}')

if [ -z "$PIDS" ]; then
  echo "No kafka server to stop"
  exit 1
else
  kill -s TERM $PIDS
fi
