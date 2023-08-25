<p align="center">
  <img src="https://raw.githubusercontent.com/tonystrawberry/tonystrawberry.codes/main/src/images/logo.png" width="60" />
</p>
<h1 align="center">
  life.tonystrawberry.codes
</h1>

## 📚 Wordpress hosted on AWS EC2 & managed via IaC

- 🛠 Built with [Terraform](https://www.terraform.io/)
- 📚 Project for consolidating my knowledge in Terraform after getting the **Hashicorp Certified: Terraform Associate** certification [2023 August]
- 📄 Uses `terraform-docs` for automated documentation generation
- 👮‍♂️ Uses `terraform fmt -check -recursive` in Github Actions for checking format errors
- 🔖 All AWS resources are tagged with the following attributes for better management
  ```
    Project   = var.project
    ManagedBy = "Terraform"
  ```

## ⚜️ Architecture

<img src="https://raw.githubusercontent.com/tonystrawberry/life.tonystrawberry.codes/main/documentation/architecture.drawio.png" />

## 🏃🏻 Usage

1. Authenticate on AWS with Terraform using one of the [supported authentication methods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
2. Create a `terraform.tfvars` file at the root of the project that define the following variables.
  ```
  project = "life-tonystrawberry-codes"
  region  = "ap-northeast-1"
  domain  = "tonystrawberry.codes"
  ```
3. Run `terraform init` to initialize the project (download the providers).
4. Run `terraform plan` to check and validate the infrastucture changes.
5. Run `terraform apply` for provisioning the resources.
6. Login into AWS. Connect to your provisioned EC2 using Session Manager. Follow the steps below.

  ```
  # Edit the following lines in the wp-config.php file
  # using `sudo nano wordpress/wp-config.php`
  #   define('DB_NAME', 'wordpress-db');
  #   define('DB_USER', 'wordpress-user');
  #   define('DB_PASSWORD', 'wordpress');
  #
  # In the same file, find the section called `Authentication Unique Keys and Salts`
  # Replace the values in that section with the output from the following command
  # curl -s https://api.wordpress.org/secret-key/1.1/salt/
  #   define('AUTH_KEY',         ' #U$$+[RXN8:b^-L 0(WU_+ c+WFkI~c]o]-bHw+)/Aj[wTwSiZ<Qb[mghEXcRh-');
  #   define('SECURE_AUTH_KEY',  'Zsz._P=l/|y.Lq)XjlkwS1y5NJ76E6EJ.AV0pCKZZB,*~*r ?6OP$eJT@;+(ndLg');
  #   define('LOGGED_IN_KEY',    'ju}qwre3V*+8f_zOWf?{LlGsQ]Ye@2Jh^,8x>)Y |;(^[Iw]Pi+LG#A4R?7N`YB3');
  #   define('NONCE_KEY',        'P(g62HeZxEes|LnI^i=H,[XwK9I&[2s|:?0N}VJM%?;v2v]v+;+^9eXUahg@::Cj');
  #   define('AUTH_SALT',        'C$DpB4Hj[JK:?{ql`sRVa:{:7yShy(9A@5wg+`JJVb1fk%_-Bx*M4(qc[Qg%JT!h');
  #   define('SECURE_AUTH_SALT', 'd!uRu#}+q#{f$Z?Z9uFPG.${+S{n~1M&%@~gL>U>NV<zpD-@2-Es7Q1O-bp28EKv');
  #   define('LOGGED_IN_SALT',   ';j{00P*owZf)kVD+FVLn-~ >.|Y%Ug4#I^*LVd9QeZ^&XmK|e(76miC+&W&+^0P/');
  #   define('NONCE_SALT',       '-97r*V/cgxLmp?Zy4zUU4r99QQ_rGs2LTd%P;|_e1tS)8_B/,.6[=UK<J_y9?JWG');


  # Allow Wordpress to use permalinks
  # using `sudo vim /etc/httpd/conf/httpd.conf` and modify the AllowOverride directive
  #   <Directory "/var/www/html">
  #       AllowOverride All
  #   </Directory>

  ```
7. As an output, you will get an IP address which allows you to access the website using HTTP (HTTPs is not supported).
8. After testing, run `terraform destroy` to destroy all provisioned resources using Terraform.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/dns | n/a |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |
| <a name="module_identity"></a> [identity](#module\_identity) | ./modules/identity | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_region.tf-docs-provider-workaround](https://registry.terraform.io/providers/hashicorp/aws/5.13.1/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to use for the DNS zone | `string` | `"tonystrawberry.codes"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project | `string` | `"life-tonystrawberry-codes"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to launch in | `string` | `"ap-northeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wordpress_public_ip"></a> [wordpress\_public\_ip](#output\_wordpress\_public\_ip) | The public IP address of the EC2 instance |
<!-- END_TF_DOCS -->
