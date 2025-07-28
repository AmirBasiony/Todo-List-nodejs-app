
###############################
#           IAM              #
###############################
resource "aws_iam_role" "ec2_ssm_ecr_role" {
  name = "EC2SSMWithECRRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_ssm_ecr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr_attach" {
  role       = aws_iam_role.ec2_ssm_ecr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.ec2_ssm_ecr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2SSMWithECRProfile"
  role = aws_iam_role.ec2_ssm_ecr_role.name
}
 ################################
 ##############################
 ##########################



data "aws_iam_policy_document" "ansible_ssm_s3_policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:HeadBucket"
    ]
    resources = [ 
      aws_s3_bucket.ansible_ssm_bucket.arn,
      "${aws_s3_bucket.ansible_ssm_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "ansible_ssm_s3" {
  name        = "AnsibleSSMS3Policy"
  policy      = data.aws_iam_policy_document.ansible_ssm_s3_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_ansible_s3" {
  role       = aws_iam_role.ec2_ssm_ecr_role.name
  policy_arn = aws_iam_policy.ansible_ssm_s3.arn
}
