aws_vpc_id = "vpc-0d40cf14ef5b2f1c0"
aws_security_group_id = "sg-0f41c75290552498f"
prefix = "inv-qa"
#for demo after destroying everything use prefix as jcb-qa
engine = "aurora-postgresql"
engine_mode = "provisioned"
engine_version = "14.6"
master_username = "invadmin"
master_password = "invadmin"
backup_retention_period = 7
skip_final_snapshot = "true"
apply_immediately = "true"
instance_class = "db.t3.medium"
#subnet_ids = ["subnet-00d62f0e1b382499a","subnet-0fe89b6c288878cee","subnet-0cca324e71d62c8fc","subnet-00b5bfa8b1ba41e9c","subnet-0d2f4689ba99f43b3","subnet-061e82e3ce2718286"]
dbname = "inventorymgmt"
dbuser = "invadmin"
dbpwd = "invadmin"
db_dms_sec_grp_id = "sg-05dcb66f5a29581ca"
replication_instance_class = "dms.t3.medium"
source_engine_name = "aurora-postgresql"
target_engine_name = "s3"
db_server = "inv-qa-cluster-identifier.cluster-cefcmch6dncq.us-east-1.rds.amazonaws.com"
migration_type = "full-load-and-cdc"
schema_name = "invmgmtqa"
table_name = "%"
server_name_target_endpoint = ""
server_name_source_endpoint = "setupdb-instance-1.cefcmch6dncq.us-east-1.rds.amazonaws.com"
user_source_endpoint = "setupdbadmin"
pwd_source_endpoint = "setupdbadmin"
server_name_pcdb_target_endpoint = "pcdb-instance-1.cefcmch6dncq.us-east-1.rds.amazonaws.com"
user_pcdb = "pcdbadmin"
pwd_pcdb = "pcdbadmin"
server_name_kmdb_target_endpoint = "kmdb-instance-1.cefcmch6dncq.us-east-1.rds.amazonaws.com"
user_kmdb = "kmdbadmin"
pwd_kmdb = "kmdbadmin"
start_replication_task = true
replication_subnet_group_id = "sfm-dms-subnet-group-1"
replication_instance_id = "sfm-dms-replication-instance-1"
source_endpoint_id = "setupdb-source-endpoint-1"
target_endpoint_id_1 = "pcdb-target-endpoint-1"
target_endpoint_id_2 = "kmdb-target-endpoint-2"
source_db_name = "setupdb"
target_db_name_1 = "pcdb"
target_db_name_2 = "kmdb"
replication_task_id_1 = "pcdb-repl-task-1"
replication_task_id_2 = "kmdb-repl-task-1"
