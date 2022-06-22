# Create key pair

# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "key_pair_ubuntu" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "key_pair_centos" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the Key Pair
resource "aws_key_pair" "key_pair_ubuntu" {
  key_name   = "${lower(var.app_name)}-${lower(var.app_environment)}-${lower(var.aws_region)}"
  public_key = tls_private_key.key_pair_ubuntu.public_key_openssh
}

# Create the Key Pair
resource "aws_key_pair" "key_pair_centos" {
  key_name   = "${lower(var.app_name_centos)}-${lower(var.app_environment_centos)}-${lower(var.aws_region)}"
  public_key = tls_private_key.key_pair_centos.public_key_openssh
}

# Save file
resource "local_file" "ssh_key_ubuntu" {
  filename = "${aws_key_pair.key_pair_ubuntu.key_name}.pem"
  content  = tls_private_key.key_pair_ubuntu.private_key_pem
}

resource "local_file" "ssh_key_centos" {
  filename = "${aws_key_pair.key_pair_centos.key_name}.pem"
  content  = tls_private_key.key_pair_centos.private_key_pem
}
