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
source ${HAWQ_HOME}/greenplum_path.sh
export PXF_HOME=${GPHOME}/pxf

sudo echo "source ${GPHOME}/greenplum_path.sh" >> /home/gpadmin/.bashrc

cd /data/hawq/pxf
make
make install

sudo sed 's|-pxf|-gpadmin|g' -i ${PXF_HOME}/conf/pxf-env.sh

rm -rf ${PXF_HOME}/conf/pxf-log4j.properties
cat <<EOF >>${PXF_HOME}/conf/pxf-log4j.properties
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
log4j.appender.ROLLINGFILE.File=${PXF_HOME}/pxf-service/logs/pxf-service.log
log4j.appender.ROLLINGFILE.MaxFileSize=10MB
log4j.appender.ROLLINGFILE.MaxBackupIndex=10
log4j.appender.ROLLINGFILE.layout=org.apache.log4j.PatternLayout
log4j.appender.ROLLINGFILE.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss.SSSS} %p %t %c - %m%n
EOF

rm -rf ${PXF_HOME}/conf/pxf-private.classpath
cat <<EOF >>${PXF_HOME}/conf/pxf-private.classpath
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##################################################################
# This file contains the internal classpaths required to run PXF.
# Edit to set the base paths according to your specific package layout
# Adding new resources should be done using pxf-public.classpath file.
##################################################################

# PXF Configuration
/data/hawq-devel/pxf/conf

# Hadoop Configuration
/usr/hdp/2.5.0.0-1245/hadoop/etc/hadoop

# Hive Configuration
# hive/conf

# Hbase Configuration
# base/conf

# PXF Libraries
/data/hawq-devel/pxf/lib/pxf-hbase-*[0-9].jar
/data/hawq-devel/pxf/lib/pxf-hdfs-*[0-9].jar
/data/hawq-devel/pxf/lib/pxf-hive-*[0-9].jar
/data/hawq-devel/pxf/lib/pxf-json-*[0-9].jar
/data/hawq-devel/pxf/lib/pxf-jdbc-*[0-9].jar
/data/hawq-devel/pxf/lib/pxf-ignite-*[0-9].jar

# Hadoop Libraries
/usr/hdp/2.5.0.0-1245/hadoop/client/hadoop-hdfs-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/hadoop-mapreduce-client-core-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/hadoop-auth-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/hadoop-common-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/lib/asm-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/avro-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-cli-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-codec-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-collections-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-configuration-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-io-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-lang-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-logging-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/commons-compress-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/guava-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/htrace-core*.jar
/usr/hdp/2.5.0.0-1245/hadoop/client/jetty-*.jar
/usr/hdp/2.5.0.0-1245/hadoop/client/jackson-core-asl-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/jackson-mapper-asl-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/lib/jersey-core-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/lib/jersey-server-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/log4j-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/protobuf-java-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/slf4j-api-*[0-9].jar
/usr/hdp/2.5.0.0-1245/hadoop/client/gson-*[0-9].jar

# Hive Libraries
# hive/lib/antlr-runtime*.jar
# hive/lib/datanucleus-api-jdo*.jar
# hive/lib/datanucleus-core*.jar
# hive/lib/hive-exec*.jar
# hive/lib/hive-metastore*.jar
# hive/lib/jdo-api*.jar
# hive/lib/libfb303*.jar
# when running on OSx, 1.0.5 or higher version is required
# hive/lib/snappy-java*.jar

# HBase Libraries
# hbase/lib/hbase-client*.jar
# hbase/lib/hbase-common*.jar
# hbase/lib/hbase-protocol*.jar
# hbase/lib/htrace-core*.jar
# hbase/lib/netty*.jar
# hbase/lib/zookeeper*.jar
# hbase/lib/metrics-core*.jar
EOF

echo "Make PXF Done!"
