resource "aws_vpc" "EC2VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "VPC_TecnoCT"
        projeto = "oficina13_grupo06_humhub"
    }
}

resource "aws_vpc_ipv4_cidr_block_association" "EC2VPCCidrBlock" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "us-east-1a"
    cidr_block = "10.0.3.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "us-east-1b"
    cidr_block = "10.0.2.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet3" {
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet4" {
    availability_zone = "us-east-1b"
    cidr_block = "10.0.4.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "EC2InternetGateway" {
    tags = {
        Name = "internet_gateway_TecnoCT"
        projeto = "oficina13_grupo06_humhub"
    }
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_vpc_dhcp_options_association" "EC2VPCDHCPOptionsAssociation" {
    dhcp_options_id = "dopt-0c4fd45c71efd4a03"
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_network_acl" "EC2NetworkAcl" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "ACL_Humhub_privada"
        projeto = "projeto13_grupo06-humhub"
    }
}

resource "aws_network_acl" "EC2NetworkAcl2" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "ACL_Humhub_publica"
        projeto = "projeto13_grupo06-humhub"
    }
}

resource "aws_network_acl_rule" "EC2NetworkAclEntry" {
    cidr_block = "0.0.0.0/0"
    egress = true
    network_acl_id = "acl-01b1d787306aa56a8"
    protocol = -1
    rule_action = "allow"
    rule_number = 100
}

resource "aws_network_acl_rule" "EC2NetworkAclEntry2" {
    cidr_block = "0.0.0.0/0"
    egress = false
    network_acl_id = "acl-01b1d787306aa56a8"
    protocol = 6
    rule_action = "allow"
    rule_number = 22
}

resource "aws_network_acl_rule" "EC2NetworkAclEntry3" {
    cidr_block = "0.0.0.0/0"
    egress = false
    network_acl_id = "acl-01b1d787306aa56a8"
    protocol = 6
    rule_action = "allow"
    rule_number = 100
}

resource "aws_network_acl_rule" "EC2NetworkAclEntry4" {
    cidr_block = "0.0.0.0/0"
    egress = false
    network_acl_id = "acl-01b1d787306aa56a8"
    protocol = 6
    rule_action = "allow"
    rule_number = 120
}

resource "aws_route_table" "EC2RouteTable" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {}
}

resource "aws_route_table" "EC2RouteTable2" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "rt_TecnoCT_publica"
        projeto = "oficina13_grupo06_humhub"
    }
}

resource "aws_route_table" "EC2RouteTable3" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "rt_TecnoCT_privada_b"
    }
}

resource "aws_route_table" "EC2RouteTable4" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        projeto = "oficina13_grupo06_humhub"
        Name = "rt_TecnoCT_privada_a"
    }
}

resource "aws_route" "EC2Route" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "igw-00080859062e6a6d2"
    route_table_id = "rtb-0ddba3efd0d9e0d55"
}

resource "aws_route" "EC2Route2" {
    destination_ipv6_cidr_block = "::/0"
    gateway_id = "igw-00080859062e6a6d2"
    route_table_id = "rtb-0ddba3efd0d9e0d55"
}

resource "aws_route" "EC2Route3" {
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "nat-0ac209202e621941e"
    route_table_id = "rtb-05cb80d6c4b116043"
}

resource "aws_route" "EC2Route4" {
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "nat-0e1fba3d48050974f"
    route_table_id = "rtb-0cb18f8f6428f1e38"
}

resource "aws_nat_gateway" "EC2NatGateway" {
    subnet_id = "subnet-0a390dba7f2844740"
    tags = {
        Name = "nat-gateway-publica02-tecnoct"
    }
    allocation_id = "eipalloc-0c1b19ce86e4a6477"
}

resource "aws_nat_gateway" "EC2NatGateway2" {
    subnet_id = "subnet-0ac95c2de31a38263"
    tags = {
        Name = "nat-gateway-publica01-tecnoct"
    }
    allocation_id = "eipalloc-0eca22de47e69d62a"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation" {
    route_table_id = "rtb-0ddba3efd0d9e0d55"
    subnet_id = "subnet-0a390dba7f2844740"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation2" {
    route_table_id = "rtb-0ddba3efd0d9e0d55"
    subnet_id = "subnet-0ac95c2de31a38263"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation3" {
    route_table_id = "rtb-05cb80d6c4b116043"
    subnet_id = "subnet-03501111fcb327952"
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation4" {
    route_table_id = "rtb-0cb18f8f6428f1e38"
    subnet_id = "subnet-073ccf2a4c31ad461"
}

# TODO Elastic IP
resource "aws_eip" "EC2EIP" {
    vpc = true
}

resource "aws_eip_association" "EC2EIPAssociation" {
    allocation_id = "eipalloc-0c1b19ce86e4a6477"
    network_interface_id = "eni-06ef263d3119af53b"
    private_ip_address = "10.0.2.191"
}

resource "aws_eip" "EC2EIP2" {
    vpc = true
}

resource "aws_eip_association" "EC2EIPAssociation2" {
    allocation_id = "eipalloc-0eca22de47e69d62a"
    network_interface_id = "eni-0ec9415603ea25dba"
    private_ip_address = "10.0.1.165"
}

