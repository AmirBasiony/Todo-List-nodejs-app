resource "aws_s3_bucket" "ansible_ssm_bucket" {
  bucket = "my-ansible-ssm-bucket-2025"

  tags = {
    Name        = "AnsibleSSMBucket"
  }
}

