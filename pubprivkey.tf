provider "tls" {}

resource "tls_private_key" "ssh_key_pair" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "generated_pubkey" {
    key_name   = "instance-ssh-key"
    public_key = tls_private_key.ssh_key_pair.public_key_openssh
}

output "public_key_openssh" {
    value = tls_private_key.ssh_key_pair.public_key_openssh
    sensitive = true
}

resource "local_file" "private_key_file" {
    content  = tls_private_key.ssh_key_pair.private_key_pem
    filename = "/home/waldemar/confloss2025/aws/private_key.pem"
    file_permission = "0600"
}
