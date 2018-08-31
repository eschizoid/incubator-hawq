#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
git clone https://github.com/apache/incubator-hawq.git /data/hawq

cd /data/hawq
./configure --prefix=${HAWQ_HOME}
make -j8
make install

source ${HAWQ_HOME}/greenplum_path.sh

sudo sed 's|localhost|centos7-namenode|g' -i ${GPHOME}/etc/hawq-site.xml
sudo echo 'centos7-datanode1' >  ${GPHOME}/etc/slaves
sudo echo 'centos7-datanode2' >> ${GPHOME}/etc/slaves
sudo echo 'centos7-datanode3' >> ${GPHOME}/etc/slaves

sudo -u hdfs hdfs dfs -chown gpadmin /

echo "Make HAWQ Done!"

