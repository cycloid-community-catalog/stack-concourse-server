output "asg_concourse_sec_group_id" {
  value = "${module.concourse-server.asg_concourse_sec_group_id}"
}

output "alb_dns_name" {
  value = "${module.concourse-server.alb_dns_name}"
}

output "alb_zone_id" {
  value = "${module.concourse-server.alb_zone_id}"
}

output "nlb_dns_name" {
  value = "${module.concourse-server.nlb_dns_name}"
}

output "nlb_zone_id" {
  value = "${module.concourse-server.nlb_zone_id}"
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

output "rds_database" {
  value = "${module.concourse-server.rds_database}"
}