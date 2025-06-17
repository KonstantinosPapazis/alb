################################################################################
# AWS Load Balancer Controller Helm Release
################################################################################

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.13.2" # Check for latest version

  set {
    name  = "clusterName"
    value = local.eks_cluster_id #module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  # Since you're using EKS Pod Identity, we don't need to set the IAM role ARN annotation
  # The Pod Identity Association handles the role assignment

  set {
    name  = "region"
    value = var.region # or data.aws_region.current.name
  }

  set {
    name  = "vpcId"
    value = "vpc-07e78bc62eadb1539" #module.vpc.vpc_id
  }

  # Optional: Enable logging
  set {
    name  = "enableServiceMutatorWebhook"
    value = "false"
  }

  # Optional: Set log level
  set {
    name  = "logLevel"
    value = "info"
  }

  # Optional: Enable WAFv2 support
  set {
    name  = "enableWAF"
    value = "false"
  }

  set {
    name  = "enableWAFv2"
    value = "false"
  }

  depends_on = [
    aws_eks_pod_identity_association.aws_load_balancer_controller
  ]
}

output "load_balancer_controller_info" {
  description = "Information about AWS Load Balancer Controller"
  value = {
    helm_release = helm_release.aws_load_balancer_controller.name
    namespace    = helm_release.aws_load_balancer_controller.namespace
    iam_role_arn = aws_iam_role.aws_load_balancer_controller.arn
  }
}

