# resource "service_name" "resource_identifier_in_terraform" {
resource "aws_security_group" "ci_sg" {
  name        = "ci-server-sg"
  description = "Security group for Jenkins server"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ci-server-sg"
  }
}

resource "aws_security_group" "prod_sg" {
  name        = "production-server-sg"
  description = "Security group for production server(s)"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-server-sg"
  }
}

resource "aws_instance" "ci_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.ci_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  tags = {
    Name = "ci-server"
  }
}
resource "aws_instance" "prod_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.prod_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  tags = {
    Name = "prod-server"
  }
}
