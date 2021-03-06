# acid
Hive ACID examples

Compare/Contrast with HBase
Keep short on V1
Hive DWC


CREATE DATABASE jbarnett;
use jbarnett;

-- Get table location
SHOW CREATE TABLE people;

-- 1. Insert
INSERT OVERWRITE TABLE people
SELECT id, first_name, last_name, email, gender, phone_nbr
FROM default.people_raw
WHERE id BETWEEN 1 AND 10;

hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people

!sh hdfs dfs -ls -R hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people
drwxrwx---+  - hive hadoop          0 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/_orc_acid_version
-rw-rw----+  3 hive hadoop       1716 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/bucket_00000



-- 2. Update
UPDATE people SET 
  last_name = CONCAT(last_name,'X'),
  first_name = CONCAT(first_name,'X')
WHERE  id BETWEEN 1 AND 5;

-- hdfs dfs -ls -R <table location>

drwxrwx---+  - hive hadoop          0 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/_orc_acid_version
-rw-rw----+  3 hive hadoop       1716 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop        835 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop       1544 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000/bucket_00000


-- 3. New Inserts
INSERT INTO people
SELECT id, first_name, last_name, email, gender, phone_nbr
FROM default.people_raw
WHERE id BETWEEN 11 AND 20;

drwxrwx---+  - hive hadoop          0 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/_orc_acid_version
-rw-rw----+  3 hive hadoop       1716 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop        835 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop       1544 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:03 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000003_0000003_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:03 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000003_0000003_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop       1737 2020-02-10 17:03 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000003_0000003_0000/bucket_00000

-- 4. Delete
DELETE FROM people WHERE id = 1;

drwxrwx---+  - hive hadoop          0 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/_orc_acid_version
-rw-rw----+  3 hive hadoop       1716 2020-02-10 17:00 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/base_0000001/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop        835 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000002_0000002_0000/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:04 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000004_0000004_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:04 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000004_0000004_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop        830 2020-02-10 17:04 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delete_delta_0000004_0000004_0000/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop       1544 2020-02-10 17:02 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000002_0000002_0000/bucket_00000
drwxrwx---+  - hive hadoop          0 2020-02-10 17:03 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000003_0000003_0000
-rw-rw----+  3 hive hadoop          1 2020-02-10 17:03 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000003_0000003_0000/_orc_acid_version
-rw-rw----+  3 hive hadoop       1737 2020-02-10 17:03 hdfs://c316-node2.squadron.support.hortonworks.com:8020/warehouse/tablespace/managed/hive/jbarnett.db/people/delta_0000003_0000003_0000/bucket_00000

5. Compaction
ALTER TABLE people COMPACT 'minor';
SHOW COMPACTIONS;

-- 4. Merge
MERGE INTO people TGT
USING (
-- Inserts
SELECT id, first_name, last_name, email, gender, phone_nbr
FROM default.people_raw
WHERE id BETWEEN 21 AND 30
UNION ALL
-- Updates
SELECT id, CONCAT(first_name,'Y') AS first_name, CONCAT(last_name,'Y') AS last_name, email, gender, phone_nbr
FROM default.people_raw
WHERE id BETWEEN 11 AND 20
) SRC
ON SRC.id = TGT.id
WHEN NOT MATCHED THEN UPDATE SET
  first_name = SRC.first_name,
  last_name = SRC.last_name
WHEN NOT MATCHED THEN INSERT VALUES 
 (SRC.id, SRC.first_name, SRC.last_name, SRC.email, SRC.gender, SRC.phone_nbr);
 
 

https://screamingweasel.s3.us-west-2.amazonaws.com/people.csv