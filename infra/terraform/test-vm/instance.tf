resource "openstack_compute_instance_v2" "vm1" {
	name = "test-vm"
	flavor_id = data.openstack_compute_flavor_v2.small.id
	image_id = data.openstack_images_image_v2.cirros.id
	key_pair = "demo-key"
	
	network {
		name = "demo-net"
	}
}