resource "openstack_compute_instance_v2" "k8s_control_plane" {
	name = "k8s-control-plane"
	flavor_id = openstack_compute_flavor_v2.k8s_control.id
	image_id = openstack_images_image_v2.ubuntu.id
	key_pair = "demo-key"
	security_groups = [openstack_networking_secgroup_v2.k8s_secgroup.name]

	network {
		uuid = openstack_networking_network_v2.k8s_net.id
	}
}

resource "openstack_compute_instance_v2" "k8s_worker" {
	count = var.worker_count
	name = "k8s-node-${count.index + 1}"
	flavor_id = openstack_compute_flavor_v2.k8s_worker.id
	image_id = openstack_images_image_v2.ubuntu.id
	key_pair = "demo-key"
	security_groups = [openstack_networking_secgroup_v2.k8s_secgroup.name]

	network {
		uuid = openstack_networking_network_v2.k8s_net.id
	}
}
