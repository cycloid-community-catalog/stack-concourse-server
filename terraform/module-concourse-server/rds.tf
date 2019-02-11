####

# RDS PostgreSQL

###
resource "aws_security_group" "rds-concourse" {
  name        = "${var.project}-rds-concourse-${var.env}"
  description = "rds-concourse ${var.env} for ${var.project}"
  name        = "${var.project}-rds-concourse-${var.env}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.concourse.id}",
    ]
  }

  tags {
    cycloid.io = "true"
    Name       = "${var.project}-rds-concourse-${var.env}"
    client     = "${var.customer}"
    env        = "${var.env}"
    project    = "${var.project}"
    role       = "rds-concourse"
  }
}

resource "aws_db_parameter_group" "rds-optimized-postgresql" {
  name        = "${var.project}-rds-optimized-postgresql-${var.env}"
  family      = "${var.rds_postgresql_family}"
  description = "PostgreSQL ${var.env} optimizations for ${var.project}"
}

resource "aws_db_instance" "concourse" {
  depends_on        = ["aws_security_group.rds-concourse"]
  identifier        = "${var.project}-rds-concourse-${var.env}"
  allocated_storage = "${var.rds_disk_size}"
  storage_type      = "${var.rds_storage_type}"
  engine            = "${var.rds_engine}"
  engine_version    = "${var.rds_engine_version}"
  instance_class    = "${var.rds_type}"
  name              = "${var.rds_database}"
  username          = "${var.rds_username}"
  password          = "${var.rds_password}"

  multi_az                  = "${var.rds_multiaz}"
  apply_immediately         = true
  maintenance_window        = "${var.rds_maintenance_window}"
  backup_window             = "${var.rds_backup_window}"
  backup_retention_period   = "${var.rds_backup_retention}"
  final_snapshot_identifier = "${var.customer}-${var.project}-rds-concourse-${lookup(var.short_region, var.aws_region)}-${var.env}"
  skip_final_snapshot       = "${var.rds_skip_final_snapshot}"
  copy_tags_to_snapshot     = true

  parameter_group_name    = "${var.rds_parameters == "" ? aws_db_parameter_group.rds-optimized-postgresql.id : var.rds_parameters}"
  db_subnet_group_name    = "${var.rds_subnet}"
  vpc_security_group_ids  = ["${aws_security_group.rds-concourse.id}"]

  tags {
    cycloid.io = "true"
    Name       = "${var.customer}-${var.project}-rds-concourse-${lookup(var.short_region, var.aws_region)}-${var.env}"
    client     = "${var.customer}"
    env        = "${var.env}"
    project    = "${var.project}"
    role       = "rds-concourse"
  }
}

resource "aws_db_subnet_group" "rds-subnet" {
  name        = "engine-cycloid.io_subnet-rds-${var.vpc_id}"
  count       = "${var.rds_subnet != "" ? 0 : 1}"
  description = "subnet-rds-${var.vpc_id}"
  subnet_ids  = ["${var.private_subnets_ids}"]
}
