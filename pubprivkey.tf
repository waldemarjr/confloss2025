provider "tls" {}

resource "tls_private_key" "ssh_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pubkey" {
  key_name   = "${var.project_name}-pubkey"
  public_key = tls_private_key.ssh_key_pair.public_key_openssh
}

resource "local_file" "private_key_file" {
  content         = tls_private_key.ssh_key_pair.private_key_pem
  filename        = "/home/waldemar/confloss2025/aws/${var.project_name}-privkey.pem"
  file_permission = "0600"
}
