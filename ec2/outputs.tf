output "arn" {
  value = aws_instance.instance.arn
}

output "id" {
  value = aws_instance.instance.id
}

# output "name" {
#   value = aws_instance.instance.name
# }

output "aws_iam_instance_profile_arn" {
  value = aws_iam_instance_profile.profile.arn
}

output "subnet" {
  value = aws_subnet.my_subnet.id
}