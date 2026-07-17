variable "aws_region" {
  description = "AWS default region"
  type        = string
  default     = "ap-south-1"
}

variable "key_pair_name" {
  description = "Name of the key pair to use for the instance"
  type        = string
}