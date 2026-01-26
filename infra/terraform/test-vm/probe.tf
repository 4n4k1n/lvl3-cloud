data "openstack_compute_flavor_v2" "small" {
	name = "m1.small"
}

data "openstack_images_image_v2" "cirros" {
	name = "cirros-0.6.3-x86_64-disk"
	most_recent = true
}