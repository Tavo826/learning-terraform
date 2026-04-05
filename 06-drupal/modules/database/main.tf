resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group-${var.project_name}-${var.env}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "DB-Subnet-Group-${var.project_name}-${var.env}"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "db-${var.project_name}-${var.env}"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  parameter_group_name   = aws_db_parameter_group.main.name
  backup_retention_period = 7

  tags = {
    Name = "DB-${var.project_name}-${var.env}"
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "db-params-${var.project_name}-${var.env}"
  family = "mysql8.0"

  parameter {
    name  = "max_connections"
    value = "100"
  }

  parameter {
    name  = "connect_timeout"
    value = "15"
  }

  tags = {
    Name = "DB-Params-${var.project_name}-${var.env}"
  }
}