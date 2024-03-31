resource "aws_instance" "web" {
  ami           = ami-0f3c7d07486cad139
  instance_type = "t2.micro"
  security_groups = sg-05f9f061d6e0805f8
  tags = {
    Name = "Web"
  }
}