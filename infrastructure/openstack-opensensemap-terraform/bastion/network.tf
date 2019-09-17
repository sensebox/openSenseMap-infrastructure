resource "openstack_networking_network_v2" "internal" {
  name   = "osem-internal"
}


resource "openstack_networking_subnet_v2" "internal-subnet" {
  name                = "internal-subnet"
  network_id          = "${openstack_networking_network_v2.internal.id}"
  cidr                = "192.168.1.0/24"
  dns_nameservers     = ["8.8.8.8"]
}

# ROUTER
resource "openstack_networking_router_v2" "external-router" {
  name    = "external-router"
  external_network_id = "${var.external_network_id}"
}

resource "openstack_networking_router_interface_v2" "external-interface" {
  router_id           = "${openstack_networking_router_v2.external-router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.internal-subnet.id}"
}