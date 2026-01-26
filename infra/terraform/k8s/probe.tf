data "openstack_compute_flavor_v2" "custom" {
	name = "k8s.custom"
}

data "openstack_images_image_v2" "ubuntu" {
	name = "ubuntu-22.04"
	most_recent = true
}