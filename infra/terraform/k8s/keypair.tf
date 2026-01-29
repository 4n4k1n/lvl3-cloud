# Generate RSA key pair
resource "tls_private_key" "k8s_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Register public key with OpenStack
resource "openstack_compute_keypair_v2" "k8s_key" {
  name       = "k8s-key"
  public_key = tls_private_key.k8s_key.public_key_openssh
}

# Save private key for Ansible
resource "local_file" "private_key" {
  content         = tls_private_key.k8s_key.private_key_pem
  filename        = "${path.module}/../../ansible/k8s_key.pem"
  file_permission = "0600"
}
