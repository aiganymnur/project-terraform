data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
resource "aws_instance" "group-3" {
    ami = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = "t2.micro"
    key_name= aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    user_data = file("apache.sh")

    tags = {
        Name = "group-3"
    }
}

output ec2 {
    value = aws_instance.group-3.public_ip
}

