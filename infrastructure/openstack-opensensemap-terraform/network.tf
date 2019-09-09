### NETWORKING CONFIGURATION

## NETWORKS

# External Network
resource "openstack_networking_network_v2" "external" {
  name   = "osem-external"
}

# Interal Network
resource "openstack_networking_network_v2" "internal" {
  name   = "osem-internal"
}

## ROUTER
resource "openstack_networking_router_v2" "external-router" {
  name    = "external-router"
  external_network_id = "${var.external_network_id}"
}

## SUBNETS
resource "openstack_networking_subnet_v2" "internal-subnet" {
  name                = "internal-subnet"
  network_id          = "${openstack_networking_network_v2.internal.id}"
  cidr                = "192.168.1.0/24"
  dns_nameservers     = ["8.8.8.8"]
}

resource "openstack_networking_subnet_v2" "external-subnet" {
  name                = "external-subnet"
  network_id          = "${openstack_networking_network_v2.external.id}"
  cidr                = "192.168.2.0/24"
  dns_nameservers     = ["8.8.8.8"]
}


# Interfaces

resource "openstack_networking_router_interface_v2" "external-interface" {
  router_id           = "${openstack_networking_router_v2.external-router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.external-subnet.id}"
}