
resource "aws_subnet" "my_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.16.10.0/24"

  tags = var.tags
}

resource "aws_network_interface" "network" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]
  tags = var.tags
}

resource "aws_iam_instance_profile" "profile" {
  name = var.name
  role = var.role
}

resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile  = aws_iam_instance_profile.profile.arn

  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }
  tags = var.tags
}


