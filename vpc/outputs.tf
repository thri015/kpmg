output "arn" {
  value      = aws_vpc.my_vpc.arn
}

output "id" {
  value      = aws_vpc.my_vpc.id
}

output "name" {
  value      = aws_vpc.my_vpc.name
}

output "cidr_block" {
  value = aws_vpc.my_vpc.cidr_block
}
