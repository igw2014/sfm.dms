resource "aws_dms_replication_subnet_group" "dms_subnet_group" {
  replication_subnet_group_description = "dms subnet group"  
  replication_subnet_group_id          = "sfm-dms-subnet-group"  

  subnet_ids = data.aws_subnets.aws_subnets.ids

}

resource "aws_dms_replication_instance" "dms_replication_instance" {
  allocated_storage            = 50
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  multi_az                     = false
  publicly_accessible          = false
  replication_instance_class   = "dms.t3.medium"
  engine_version               = "3.5.1"
  replication_instance_id      = "sfm-dms-replication-instance"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dms_subnet_group.id
  vpc_security_group_ids = [data.aws_security_group.aws_security_group.id]
}

resource "aws_dms_endpoint" "setupdb_source_endpoint" {
  endpoint_id                 = "setupdb-source-endpoint" 
  endpoint_type               = "source"
  engine_name                 = "aurora-postgresql"
  database_name               = "setupdb"
  server_name                 = var.server_name_source_endpoint
  username                    = var.user_source_endpoint
  password                    = var.pwd_source_endpoint
  port                        = 5432
}

resource "aws_dms_endpoint" "pcdb_target_endpoint" {
  endpoint_id                 = "pcdb-target-endpoint" 
  endpoint_type               = "target"
  engine_name                 = "aurora-postgresql"
  database_name               = "pcdb"
  server_name                 = var.server_name_pcdb_target_endpoint
  username                    = var.user_pcdb
  password                    = var.pwd_pcdb
  port                        = 5432
}

resource "aws_dms_endpoint" "kmdb_target_endpoint" {
  endpoint_id                 = "kmdb-target-endpoint" 
  endpoint_type               = "target"
  engine_name                 = "aurora-postgresql"
  database_name               = "kmdb"
  server_name                 = var.server_name_kmdb_target_endpoint
  username                    = var.user_kmdb
  password                    = var.pwd_kmdb
  port                        = 5432
}

resource "aws_dms_replication_task" "pcdb_repl_task" {

  replication_task_id = "pcdb-repl-task"
  start_replication_task    = var.start_replication_task
  migration_type            = var.migration_type
  replication_instance_arn  = aws_dms_replication_instance.dms_replication_instance.replication_instance_arn
  source_endpoint_arn       = aws_dms_endpoint.setupdb_source_endpoint.endpoint_arn
  target_endpoint_arn       = aws_dms_endpoint.pcdb_target_endpoint.endpoint_arn
  replication_task_settings = file("${path.module}/config/pcdb-replication-task-settings.json")
  table_mappings = file("${path.module}/config/pcdb-replication-task-table-mappings.json")
}

resource "aws_dms_replication_task" "kmdb_repl_task" {

  replication_task_id = "kmdb-repl-task"
  start_replication_task    = var.start_replication_task
  migration_type            = var.migration_type
  replication_instance_arn  = aws_dms_replication_instance.dms_replication_instance.replication_instance_arn
  source_endpoint_arn       = aws_dms_endpoint.setupdb_source_endpoint.endpoint_arn
  target_endpoint_arn       = aws_dms_endpoint.kmdb_target_endpoint.endpoint_arn
  replication_task_settings = file("${path.module}/config/kmdb-replication-task-settings.json")
  table_mappings            = file("${path.module}/config/kmdb-replication-task-table-mappings.json")
}