resource "openstack_compute_keypair_v2" "k8s_key" {
	name       = "demo-key"
	public_key = file("~/.ssh/id_rsa.pub")
}
