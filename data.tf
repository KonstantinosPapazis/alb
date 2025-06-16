data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

data "aws_eks_cluster" "eks_cluster" {
  name = "eks-cluster"
}