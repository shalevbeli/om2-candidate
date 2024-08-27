output "private_key" {
    value=tls_private_key.generate_public_key.private_key_pem
    description = "private key for retrieving the password later on"
    sensitive = true
}

output "public_ip" {
    value = aws_instance.my-server.public_ip
    description = "The public ip of my vm"
}

output "Dns-name" {
    value = aws_instance.my-server.public_dns
    description = "My server public dns"
}