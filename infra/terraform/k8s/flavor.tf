resource "openstack_compute_flavor_v2" "k8s_control" {
	name      = "k8s.control"
	vcpus     = 2
	ram       = 6144
	disk      = 10
	is_public = true
}

resource "openstack_compute_flavor_v2" "k8s_worker" {
	name      = "k8s.worker"
	vcpus     = 1
	ram       = 4096
	disk      = 10
	is_public = true
}
