resource "openstack_networking_floatingip_v2" "control_fip" {
	pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "control_fip" {
	floating_ip = openstack_networking_floatingip_v2.control_fip.address
	instance_id = openstack_compute_instance_v2.k8s_control_plane.id
}

resource "openstack_networking_floatingip_v2" "worker_fip" {
	count = var.worker_count
	pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "worker_fip" {
	count = var.worker_count
	floating_ip = openstack_networking_floatingip_v2.worker_fip[count.index].address
	instance_id = openstack_compute_instance_v2.k8s_worker[count.index].id
}

output "control_plane_ip" {
	value = openstack_networking_floatingip_v2.control_fip.address
}

output "worker_ip" {
	value = openstack_networking_floatingip_v2.worker_fip[*].address
}