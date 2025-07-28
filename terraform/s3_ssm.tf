resource "aws_s3_bucket" "ansible_ssm_bucket" {
  bucket = "my-ansible-ssm-bucket-2025"

  tags = {
    Name        = "AnsibleSSMBucket"
  }
}

output "ansible_ssm_bucket_name" {
  value       = aws_s3_bucket.ansible_ssm_bucket.id
  description = "Name of the S3 bucket used for Ansible SSM"
}
