
data "template_file" "cb_app" {
  template = file("${path.module}/template/app.json")

  vars = {
    name_container = var.name
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region
    aws_awslogs    = aws_cloudwatch_log_group.cb_log_group.name
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.name
  execution_role_arn       = aws_iam_role.main_ecs_tasks.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.cb_app.rendered
  tags                  = var.tags
}

