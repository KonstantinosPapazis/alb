output "aws_load_balancer_controller_role_arn" {
  description = "The ARN of the AWS Load Balancer Controller IAM role"
  value       = aws_iam_role.aws_load_balancer_controller.arn
}

output "aws_load_balancer_controller_pod_identity_association_id" {
  description = "The ID of the EKS Pod Identity Association for AWS Load Balancer Controller"
  value       = aws_eks_pod_identity_association.aws_load_balancer_controller.association_id
}

output "ingress_alb_dns" {
  description = "DNS name of the ALB created by the Ingress (may take a few minutes to appear)"
  value       = "Check with: kubectl get ingress -n example-app"
}