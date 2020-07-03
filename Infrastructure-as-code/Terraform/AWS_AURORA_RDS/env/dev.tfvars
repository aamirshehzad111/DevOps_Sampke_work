name = "aurora-test"
environment = "stagging"
server_count = 1
instance_type = "db.r4.large"
apply_immediately = false
publicly_accessible = false
engine = "aurora-mysql"
engine_version = "5.7.mysql_aurora.2.03.2"
db_name = "auroraStagingDB"
db_port = 3306
admin_user = "admin"
admin_password = "er12345678"
deletion_protection = false
backup_retention_period = 7
preferred_backup_window = "02:00-03:00"
vpc_id = "vpc-a0eeacda"
subnets = [
  "subnet-170b3739",
  "subnet-2a82b44d"]
instance_availability_zone = [
  "us-east-1d",
  "us-east-1c"]
security_groups = [
  "sg-23462472"]
vpc_security_group_ids = [
  "sg-23462472"]
allowed_cidr_blocks = [
  "0.0.0.0/0"]
enabled_cloudwatch_logs_exports = [
  "slowquery",
  "general",
  "error",
  "audit"]
rds_monitoring_interval = 0
rds_monitoring_role_arn = "arn:aws:iam::96041754235:role/rds-monitoring-role"
pattern_name = "Query_time"
dashboard_name = "Slow-Query-Log"
region = "us-east-1"
