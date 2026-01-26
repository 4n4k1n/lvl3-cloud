resource "local_file" "ansible_inventory" {
	content = templatefile("${path.module}/inventory.tpl", {
		control_ip = openstack_networking_floatingip_v2.control_fip.address
		worker_ips = openstack_networking_floatingip_v2.worker_fip[*].address
	})

	filename = "${path.module}/../../ansible/inventory.ini"
}