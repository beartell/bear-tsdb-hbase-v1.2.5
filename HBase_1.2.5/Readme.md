   # Start HBase
docker run -td -v /media/miwgates/Depo/Projeler_Docker/bin/HBase_1.2.5/config:/HBaseConfig -e CREATE_SCHEMA=1 -e CONFIG_FILE_PATH=/HBaseConfig -e HBASE_CONFIG_FILE_PATH=/HBaseConfig/conf --name HbaseSA bear/hbase-1.2:opentsdb-2.3



- docker run -td -v /media/miwgates/Depo/Projeler_Docker/bin/HBase_1.2.5/config:/tmp/config -e CREATE_KEYSPACES=1 -e CONFIG_FILE_PATH=/tmp/config -e HBASE_CONFIG_FILE_PATH=/tmp/config/conf --name hbase bear/hbase:1.2.5