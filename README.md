# stack-concourse-server

Concourse is an open-source continuous thing-doer.
Built on the simple mechanics of resources, tasks, and jobs, Concourse presents a general approach to automation that makes it great for CI/CD.

## Architecture

This stack will deploy a Concourse server (web+atc) on an Amazon EC2 instance behind an ALB load balancer, using PostgreSQL for Cycloid.io.

![](https://cdn.jsdelivr.net/gh/cycloid-community-catalog/stack-concourse-server@master/diagram.svg)

  * **ALB**: Amazon application loadbalancer
  * **ASG**: Autoscaling group for fronts
  * **concourse-server**: EC2 instances from builded AMI
  * **RDS**: Amazon RDS database (PostgreSQL)

> **Pipeline** The pipeline contains a manual approval between terraform plan and terraform apply.
> That means if you trigger a terraform plan, to apply it, you have to go on terraform apply job
> and click on the `+` button to trigger it.

## Requirements

In order to run this task, couple elements are required within the infrastructure:

  * Having a VPC with private & public subnets containing a bastion server that can access instances by SSH
  * Having an S3 bucket for terraform remote states

## Details

**Pipeline**

  * Run packer to build debian Amazon AMI with Concourse server exposing telegraph metrics (port 9100 prometheus format).
  * Clean old builded AMI

**Terraform**

Create:

  * ALB (loadbalancer), but can use your own ALB
  * ASG with launch_template of a concourse server
  * RDS

**Ansible**

  * Playbook and packer config to build a debian image with telegraf, fluentd and Concourse server (web+atc) installed.

