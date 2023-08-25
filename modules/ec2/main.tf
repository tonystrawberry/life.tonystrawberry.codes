# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

# Create an EC2 instance for the project (WordPress)
resource "aws_instance" "aws_instance_wordpress" {
  ami                    = data.aws_ami.amazon_linux_2023_ami.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  user_data              = file("./scripts/userdata.sh")
  iam_instance_profile   = aws_iam_instance_profile.aws_iam_instance_profile.name

  tags = {
    Name = "${var.project}-ec2-wordpress"
  }
}

# Create an Elastic IP for EC2 instance
resource "aws_eip" "aws_eip" {
  instance = aws_instance.aws_instance_wordpress.id
  domain   = "vpc"
}

# Get IAM policy for EC2 instance
data "aws_iam_policy" "systems_manager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Attach IAM policy to role
resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  role       = aws_iam_role.aws_iam_role.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

# Create an instance profile for role
resource "aws_iam_instance_profile" "aws_iam_instance_profile" {
  name = "${var.project}-instance-profile"
  role = aws_iam_role.aws_iam_role.name
}

# Get IAM Policy Document for role
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create an IAM role for EC2 instance
resource "aws_iam_role" "aws_iam_role" {
  name               = "${var.project}-ec2-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
