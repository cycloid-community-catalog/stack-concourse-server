output "asg_concourse_sec_group_id" {
  value = "${module.concourse-server.asg_concourse_sec_group_id}"
}

output "rds_address" {
  value = "${module.concourse-server.rds_address}"
}

output "rds_port" {
  value = "${module.concourse-server.rds_port}"
}

output "rds_username" {
  value = "${module.concourse-server.rds_username}"
}

output "rds_password" {
  value = "${var.rds_password}"
}

output "rds_database" {
  value = "${module.concourse-server.rds_database}"
}