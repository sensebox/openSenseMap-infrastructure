### NETWORKING CONFIGURATION

## NETWORKS

# External Network
# resource "openstack_networking_network_v2" "external" {
#   name   = "osem-external"
# }

# Interal Network
resource "openstack_networking_network_v2" "internal" {
  name   = "osem-internal"
}

## ROUTER
# resource "openstack_networking_router_v2" "external-router" {
#   name    = "external-router"
#   external_network_id = "${var.external_network_id}"
# }

## SUBNETS
resource "openstack_networking_subnet_v2" "internal-subnet" {
  name                = "internal-subnet"
  network_id          = "${openstack_networking_network_v2.internal.id}"
  cidr                = "192.168.1.0/24"
  # dns_nameservers     = ["8.8.8.8"] TODO: CHECK IF THIS HAS TO BE SPECIFIED OR CAN BE LEFT EMPTY (dont use 8.8.8.8, use uni-muenster DNS)
}
 
resource "openstack_networking_router_v2" "external-router" {
  name    = "external-router"
  external_network_id = "${var.external_network_id}"
}

resource "openstack_networking_router_interface_v2" "external-interface" {
  router_id           = "${openstack_networking_router_v2.external-router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.internal-subnet.id}"
}