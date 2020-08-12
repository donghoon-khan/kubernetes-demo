module "label" {
  source = "./../null-label"
  namespace = var.namespace
  stage = var.stage
  name = var.name
  attributes = var.attributes
  delimiter = var.delimiter
  tags = var.tags
}

resource "tls_private_key" "tls" {
	algorithm = var.tls_key_algorithm
}

resource "local_file" "private_key_file" {
	depends_on = [tls_private_key.tls]
	content = tls_private_key.tls.private_key_pem
	filename = "${var.ssh_key_path}/${module.label.id}${var.private_key_extension}"
}

resource "local_file" "public_key_file" {
	depends_on = [tls_private_key.tls]
	content = tls_private_key.tls.public_key_openssh
	filename = "${var.ssh_key_path}/${module.label.id}${var.public_key_extension}"
}

resource "aws_key_pair" "key_pair" {
	key_name = length(var.aws_key_name) > 0 ? var.aws_key_name : module.label.id
	public_key = tls_private_key.tls.public_key_openssh
}

resource "null_resource" "chmod" {
	count = var.chmod != "" ? 1 : 0
	depends_on = [local_file.private_key_file]

	provisioner "local-exec" {
		command = format(var.chmod, local_file.private_key_file.filename)
	}
}
