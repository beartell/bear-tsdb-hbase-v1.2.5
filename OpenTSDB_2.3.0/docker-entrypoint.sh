#!/bin/bash

OPENTSDB_HOME=/home/opentsdb

if [ -f /home/CONFIG_OK ]
then
	echo "Already configured."
else
	# JAVA Configuration
	JAVAHOME=`alternatives --list  | grep jre_openjdk | awk '{print $3}'`
	JAVAHOME1=${JAVAHOME::-4}
	echo "export JAVA_HOME=$JAVAHOME1" >> /root/.bashrc
	echo "export COMPRESSION=NONE" >> /root/.bashrc
	echo "JAVA_HOME has been set."
	
	# Hosts Configuration
	echo "$HBASE_IP_ADDRESS	$HBASE_HOSTNAME" >> /etc/hosts

	# OpenTSDB Configuration
	rm -rf $OPENTSDB_HOME/opentsdb.conf
	rm -rf $OPENTSDB_HOME/src/opentsdb.conf
	cp $OPENTSDB_CONFIG_FILE_PATH $OPENTSDB_HOME/opentsdb.conf
	cp $OPENTSDB_CONFIG_FILE_PATH $OPENTSDB_HOME/src/opentsdb.conf

	touch /home/CONFIG_OK
	echo "Configuration OK"
fi

source /root/.bashrc

# OpenTSBD arayüzü çalıştır
cd $OPENTSDB_HOME
nohup ./build/tsdb tsd &
echo "OpenTSDB Started"

# OpenTSDB test verilerini yükle
if [ $LOAD_TEST_DATA -eq 1 ]
then
	cd $OPENTSDB_HOME
	./build/tsdb import --auto-metric /home/test-data.txt.gz
fi

exec /bin/bash
