#!/bin/bash

if [ $CONFIG_FILE_PATH == "None" ]
then
	echo "CONFIG_FILE_PATH can not set."
	exit
fi
if [ $HBASE_CONFIG_FILE_PATH == "None" ]
then
	echo "HBASE_CONFIG_FILE_PATH can not set."
	exit
fi

# Global Variables
HBASEHOME=/home/hbase-1.2.5/

if [ -f /home/CONFIG_OK ]
then
	echo "Already Configured"
else
	# JAVA Configuration
	JAVAHOME=`alternatives --list  | grep jre_openjdk | awk '{print $3}'`
	JAVAHOME1=${JAVAHOME::-4}
	echo "export JAVA_HOME=$JAVAHOME1" >> /root/.bashrc
	echo "export COMPRESSION=NONE" >> /root/.bashrc
	echo "export HBASE_HOME=/home/hbase-1.2.5" >> /root/.bashrc
	echo "export PATH=\$PATH:\$HBASE_HOME/bin" >> /root/.bashrc
	echo "JAVA_HOME has been set."

	rm -rf $HBASEHOME/conf
	cp -r $CONFIG_FILE_PATH/conf $HBASEHOME/conf
fi

#
source /root/.bashrc

# HBase çalıştır
cd $HBASEHOME &&
sh ./bin/start-hbase.sh

sleep 60

if [ -f /home/CONFIG_OK ]
then
	echo "Already Configured"
else

	if [ $CREATE_SCHEMA -eq 1 ]
	then
		hbh=$HBASE_HOME
		cat $CONFIG_FILE_PATH/scripts/create_schemas.script | "$hbh/bin/hbase" shell
	fi

	touch /home/CONFIG_OK
	echo "Configuration OK"
fi

exec /bin/bash
