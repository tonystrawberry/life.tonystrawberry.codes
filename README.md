# life.tonystrawberry.codes

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.13.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/dns | n/a |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |
| <a name="module_identity"></a> [identity](#module\_identity) | ./modules/identity | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to use for the DNS zone | `string` | `"tonystrawberry.codes"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project | `string` | `"life-tonystrawberry-codes"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to launch in | `string` | `"ap-northeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wordpress_public_ip"></a> [wordpress\_public\_ip](#output\_wordpress\_public\_ip) | n/a |
<!-- END_TF_DOCS -->