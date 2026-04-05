resource "aws_ecs_cluster" "main" {
  name = "cluster-${var.project_name}-${var.env}"

  tags = {
    Name = "CLUSTER-${var.project_name}-${var.env}"
  }
}

resource "aws_lb" "main" {
  name               = "alb-${var.project_name}-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "ALB-${var.project_name}-${var.env}"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "tg-${var.project_name}-${var.env}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 60
    matcher             = "200,302,404"
  }

  tags = {
    Name = "TG-${var.project_name}-${var.env}"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "task-${var.project_name}-${var.env}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  #execution_role_arn       = aws_iam_role.ecs_execution.arn
  #task_role_arn            = aws_iam_role.ecs_task.arn
  execution_role_arn       = data.aws_iam_role.lab_role.arn
  task_role_arn            = data.aws_iam_role.lab_role.arn

  container_definitions = jsonencode([
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = var.db_host
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = var.db_name
        },
        {
          name  = "WORDPRESS_DB_USER"
          value = var.db_username
        },
        {
          name  = "WORDPRESS_DB_PASSWORD"
          value = var.db_password
        },
        {
          name  = "WORDPRESS_CONFIG_EXTRA"
          value = "define('WP_MEMORY_LIMIT', '256M');"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.main.name
          "awslogs-region"        = data.aws_region.current.id
          "awslogs-stream-prefix" = "wordpress"
        }
      }
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }
    }
  ])

  tags = {
    Name = "${var.project_name}-task"
  }
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 30

  tags = {
    Name = "LOG-GROUP-${var.project_name}-${var.env}"
  }
}

resource "aws_ecs_service" "main" {
  name            = "service-${var.project_name}-${var.env}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.ecs_tasks_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "wordpress"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.main]

  tags = {
    Name = "SERVICE-${var.project_name}-${var.env}"
  }
}

# resource "aws_iam_role" "ecs_execution" {
#   name = "ecs-execution-role-${var.project_name}-${var.env}"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       }
#     ]
#   })
#
#   tags = {
#     Name = "ECS-EXECUTION-ROLE-${var.project_name}-${var.env}"
#   }
# }
#
# resource "aws_iam_role_policy_attachment" "ecs_execution" {
#   role       = aws_iam_role.ecs_execution.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }
#
# resource "aws_iam_role" "ecs_task" {
#   name = "ecs-task-role-${var.project_name}-${var.env}"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       }
#     ]
#   })
#
#   tags = {
#     Name = "ECS-TASK-ROLE-${var.project_name}-${var.env}"
#   }
# }

data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_region" "current" {} 