data "template_file" "user_data_concourse" {
  template = "${file("${path.module}/templates/userdata.sh.tpl")}"

  vars {
    env                = "${var.env}"
    project            = "${var.project}"
    role               = "concourse-server"
    signal_stack_name  = "${var.project}-concourse-server-${var.env}"
    signal_resource_id = "concourseServer${var.env}"
  }
}
