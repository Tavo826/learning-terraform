resource "aws_instance" "master" {
  #ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2
  ami = "ami-0c7217cdde317cfec" # Ubuntu Server 22.04 LTS
  instance_type = var.master_type
  subnet_id     = var.public_subnet
  vpc_security_group_ids = [ var.sg_master_id ]
  associate_public_ip_address = true
  key_name = var.key_name
  user_data = <<-EOF
    #!/bin/bash
    PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
    curl -sfL https://get.k3s.io | K3S_TOKEN=${var.k3s_token} sh -s server \
      --tls-san=$PUBLIC_IP --write-kubeconfig-mode 644
    EOF
  tags = {
    Name = "Master-${var.env}"
    Environment = var.env
  }
}