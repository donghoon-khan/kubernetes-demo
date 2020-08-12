# ** Building EKS with Terraform **
- - -
Terraform configuration to create an Smart O&M Platform cluster(on AWS)

Adapted from https://github.com/terraform-providers/terraform-provider-aws

For details, see https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

configures an AWS account with the following resources:  
  
## **Usage**
- - -
```bash
$ terraform init
$ terraform plan
$ terraform apply #(optional)-auto-approve -input=false -var-file=user-variables.tfvars
```

- Destroy EKS
```bash
$ terraform destroy
```

## **Input**
- - -

## **Output**
- - -
