output "database_name" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.database_name)
  description = "Database name"
}

output "master_username" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.master_username)
  description = "Username for the master DB user"
}

output "cluster_identifier" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.cluster_identifier)
  description = "Cluster Identifier"
}

output "arn" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.arn)
  description = "Amazon Resource Name (ARN) of cluster"
}

output "endpoint" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.endpoint)
  description = "The DNS address of the RDS instance"
}

output "reader_endpoint" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.reader_endpoint)
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas"
}


output "dbi_resource_ids" {
  value       = aws_rds_cluster_instance.aurora_cluster_instances.*.dbi_resource_id
  description = "List of the region-unique, immutable identifiers for the DB instances in the cluster"
}

output "cluster_resource_id" {
  value       = join("", aws_rds_cluster.aurora_cluster.*.cluster_resource_id)
  description = "The region-unique, immutable identifie of the cluster"
}

output "cluster_security_groups" {
  value       = coalescelist(aws_rds_cluster.aurora_cluster.*.vpc_security_group_ids, [""])
  description = "Default RDS cluster security groups"
}
