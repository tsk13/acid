################################################################################################
# Load people_raw table
################################################################################################

hadoop fs -rm -r /tmp/people
hadoop fs -mkdir -p /tmp/people
hadoop fs -put ddl/people.csv /tmp/people/

hive -f ddl/people_raw.ddl
