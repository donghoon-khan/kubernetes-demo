locals {
  principals_readonly_access_non_empty = length(var.principals_readonly_access) > 0 ? true : false
  principals_full_access_non_empty = length(var.principals_full_access) > 0 ? true : false
  ecr_need_policy = length(var.principals_full_access) + length(var.principals_readonly_access) > 0 ? true : false
	num_of_ecr = length(var.repo_names)
}

resource "aws_ecr_repository" "default" {
  count = local.num_of_ecr
  name = var.repo_names[count.index]

  image_scanning_configuration {
    scan_on_push = var.scan_images_on_push
  }

	tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "default" {
  count = local.num_of_ecr
  repository = join("", aws_ecr_repository.default[count.index].*.name)
policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Rotate images when reach ${var.max_image_count} images stored",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.max_image_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}


data "aws_iam_policy_document" "empty" {
  count = var.enabled ? 1 : 0
}

data "aws_iam_policy_document" "resource_readonly_access" {
  count = var.enabled ? 1 : 0

  statement {
    sid = "ReadonlyAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_readonly_access
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
    ]
  }
}

data "aws_iam_policy_document" "resource_full_access" {
  count = var.enabled ? 1 : 0

  statement {
    sid = "FullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_full_access
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:StartImageScan",
    ]
  }
}

data "aws_iam_policy_document" "resource" {
  count = var.enabled ? 1 : 0
  source_json = local.principals_readonly_access_non_empty ? join("", data.aws_iam_policy_document.resource_readonly_access.*.json) : join("", data.aws_iam_policy_document.empty.*.json)
  override_json = local.principals_full_access_non_empty ? join("", data.aws_iam_policy_document.resource_full_access.*.json) : join("", data.aws_iam_policy_document.empty.*.json)
}

resource "aws_ecr_repository_policy" "default" {
	count = local.ecr_need_policy ? local.num_of_ecr : 0
  repository = join("", aws_ecr_repository.default[count.index].*.name)
  policy = join("", data.aws_iam_policy_document.resource.*.json)
}
