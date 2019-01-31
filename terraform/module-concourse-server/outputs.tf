output "role_concourse" {
  value = "${aws_iam_role.concourse.arn}"
}

# ASG
output "asg_concourse_name" {
  value = "${aws_cloudformation_stack.concourse.outputs["AsgName"]}"
}

output "asg_concourse_sec_group_id" {
  value = "${aws_security_group.concourse.id}"
}

# ALB
output "alb_sec_group_id" {
  value = "${aws_security_group.alb-concourse.id}"
}

output "alb_id" {
  value = "${aws_alb.concourse.id}"
}

# RDS
output "rds_address" {
  value = "${aws_db_instance.concourse.address}"
}

output "rds_port" {
  value = "${aws_db_instance.concourse.port}"
}

output "rds_database" {
  value = "${aws_db_instance.concourse.name}"
}

output "rds_username" {
  value = "${aws_db_instance.concourse.username}"
}