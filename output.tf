output "public_ip_proxy-server" {
  value = aws_instance.proxy-server.public_ip
}

output "private_ip_app_server" {
  value = aws_instance.app-server.private_ip
}

output "private_ip_db_server" {
  value = aws_instance.db-server.private_ip
}
