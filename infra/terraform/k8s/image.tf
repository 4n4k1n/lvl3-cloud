resource "openstack_images_image_v2" "ubuntu" {
	name             = "ubuntu-22.04"
	image_source_url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
	container_format = "bare"
	disk_format      = "qcow2"
	visibility       = "public"
}
