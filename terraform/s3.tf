resource "aws_s3_bucket" "ansible_ssm_bucket" {
  bucket = "my-ansible-ssm-bucket-2025"

  tags = {
    Name        = "AnsibleSSMBucket"
  }
}

# Create S3 Bucket for environment variables
resource "aws_s3_bucket" "project_env_vars" {
  bucket = "environment-vars-bucket-2025"

  tags = {
    Description = "Saving the Terraform state file"
  }
}

# Read the local .env file
data "local_file" "key_details" {
  filename = "../.env"
}

# Upload the .env file to S3
resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.project_env_vars.bucket  
  key    = ".env"
  content = data.local_file.key_details.content

  depends_on = [data.local_file.key_details]
}
