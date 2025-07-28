###############################
#        EC2 INSTANCE        #
###############################
resource "aws_instance" "WebServer1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_subnet_1.id
  security_groups             = [aws_security_group.WebTrafficSG.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = false
  user_data                   = file("install_ssm_agent.sh")
  tags = {
    Name = "WebServer1"
  }
}

resource "aws_instance" "WebServer2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_subnet_2.id
  security_groups             = [aws_security_group.WebTrafficSG.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = false
  user_data                   = file("install_ssm_agent.sh")
  tags = {
    Name = "WebServer2"
  }
}