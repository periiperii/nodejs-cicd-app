output "ci_public_ip" {
  value = aws_instance.ci_server.public_ip
}

output "prod_public_ip" {
  value = aws_instance.prod_server.public_ip
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}