resource "openstack_compute_instance_v2" "k8s_control_plane" {
	name = "k8s-control-plane"
	flavor_name = "k8s.control"
	image_id = data.openstack_images_image_v2.ubuntu.id
	key_pair = "demo-key"

	network {
		name = "demo-net"
	}
}

resource "openstack_compute_instance_v2" "k8s_worker" {
	count = var.worker_count
	name = "k8s-node-${count.index + 1}"
	flavor_name = "k8s.worker"
	image_id = data.openstack_images_image_v2.ubuntu.id
	key_pair = "demo-key"

	network {
		name = "demo-net"
	}
}
