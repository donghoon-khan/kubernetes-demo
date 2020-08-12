output "key_name" {
	description = "Name of SSH key."
	value = aws_key_pair.key_pair.key_name
}

output "private_key_pem" {
	description = "Content of the generated private key."
	value = join("", tls_private_key.tls.*.private_key_pem)
}

output "public_key_pub" {
	description = "Content of the generated public key."
	value = join("", tls_private_key.tls.*.public_key_openssh)
}
