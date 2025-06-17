data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

data "aws_eks_cluster" "eks_cluster" {
  name = "eks-cluster"
}

data "aws_vpc" "eks_vpc" {
  filter {
    name   = "tag:Name"
    values = ["eks-deployment"]
  }
}