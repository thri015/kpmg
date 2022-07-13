resource "aws_secretsmanager_secret" "secret" {
  name = var.name
  tags = var.tags
}



resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = <<EOF
   {
    "username": "root",
    "password": "${random_password.password.result}"
   }
EOF
}