    # Start OpenTSDB
docker run -td -v /media/miwgates/Depo/Projeler_Docker/bin/OpenTSDB_2.3.0-HBase_Standalone/config:/HBaseConfig -e HBASE_HOSTNAME=4dd3c918e8e0 -e HBASE_IP_ADDRESS=172.17.0.2 -e CONFIG_FILE_PATH=/HBaseConfig -e OPENTSDB_CONFIG_FILE_PATH=/HBaseConfig/opentsdb.conf -e LOAD_TEST_DATA=0 --name OpenTSDB4HBaseSA bear/opentsdb-2.3:hbase-1.2
