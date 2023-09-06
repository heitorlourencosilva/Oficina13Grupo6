terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_user" "IAMUser" {
    path = "/"
    name = "aws_cli_humhub"
    tags = {
        AKIA47JWRWJMCBSM3E6U = "Acessar e enviar imagem Docker"
        projeto = "projeto13_grupo06_humhub"
    }
}

resource "aws_iam_user" "IAMUser2" {
    path = "/"
    name = "heitorlourenco"
    tags = {}
}

resource "aws_iam_user" "IAMUser3" {
    path = "/"
    name = "heitorlourenco_CLI"
    tags = {
        AKIA47JWRWJMNY4KNQ46 = "Chave para geracao de infraestrutura como codigo"
    }
}

resource "aws_iam_user" "IAMUser4" {
    path = "/"
    name = "John"
    tags = {}
}

resource "aws_iam_user" "IAMUser5" {
    path = "/"
    name = "ses-smtp-user.20230903-143340"
    tags = {
        projeto = "projeto13_grupo06_humhub"
        InvokedBy = "SESConsole"
    }
}

resource "aws_iam_group" "IAMGroup" {
    path = "/"
    name = "desenvolvimento"
}

resource "aws_iam_group" "IAMGroup2" {
    path = "/"
    name = "infraestrutura"
}

resource "aws_iam_role" "IAMRole" {
    path = "/"
    name = "ec2_acesso_s3"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_role" "IAMRole2" {
    path = "/"
    name = "ecsTaskExecutionRole"
    assume_role_policy = "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Sid\":\"\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ecs-tasks.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_role" "IAMRole3" {
    path = "/"
    name = "rds-monitoring-role"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"monitoring.rds.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole" {
    aws_service_name = "elasticfilesystem.amazonaws.com"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole2" {
    aws_service_name = "ecs.application-autoscaling.amazonaws.com"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole3" {
    aws_service_name = "ecs.amazonaws.com"
    description = "Role to enable Amazon ECS to manage your cluster."
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole4" {
    aws_service_name = "backup.amazonaws.com"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole5" {
    aws_service_name = "rds.amazonaws.com"
    description = "Allows Amazon RDS to manage AWS resources on your behalf"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole6" {
    aws_service_name = "globalaccelerator.amazonaws.com"
    description = "Allows Global Accelerator to call AWS services on customer's behalf"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole7" {
    aws_service_name = "elasticloadbalancing.amazonaws.com"
    description = "Allows ELB to call AWS services on your behalf."
}

resource "aws_iam_policy" "IAMManagedPolicy" {
    name = "S3_Acesso"
    path = "/"
    policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"s3:PutObject",
				"s3:GetObject",
				"s3:ListAllMyBuckets",
				"s3:ListBucket"
			],
			"Resource": "*"
		}
	]
}
EOF
}

resource "aws_iam_policy" "IAMManagedPolicy2" {
    name = "userReadOnlyAccess"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": [
            "iam:Get*",
            "iam:List*",
            "iam:Generate*"
        ],
        "Resource": "*"
    }
}
EOF
}

resource "aws_iam_user_policy" "IAMPolicy" {
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":\"ses:SendRawEmail\",\"Resource\":\"*\"}]}"
    user = "ses-smtp-user.20230903-143340"
}

resource "aws_iam_instance_profile" "IAMInstanceProfile" {
    path = "/"
    name = "${aws_iam_role.IAMRole.name}"
    roles = [
        "${aws_iam_role.IAMRole.name}"
    ]
}

resource "aws_iam_access_key" "IAMAccessKey" {
    status = "Active"
    user = "aws_cli_humhub"
}

resource "aws_iam_access_key" "IAMAccessKey2" {
    status = "Active"
    user = "heitorlourenco_CLI"
}

resource "aws_iam_access_key" "IAMAccessKey3" {
    status = "Active"
    user = "ses-smtp-user.20230903-143340"
}

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

resource "aws_route53_zone" "Route53HostedZone" {
    name = "tecnoct.org."
}

resource "aws_route53_record" "Route53RecordSet" {
    name = "tecnoct.org."
    type = "NS"
    ttl = 172800
    records = [
        "ns-223.awsdns-27.com.",
        "ns-1538.awsdns-00.co.uk.",
        "ns-567.awsdns-06.net.",
        "ns-1303.awsdns-34.org."
    ]
    zone_id = "Z1048411IND1D7U817GK"
}

resource "aws_route53_record" "Route53RecordSet2" {
    name = "tecnoct.org."
    type = "SOA"
    ttl = 900
    records = [
        "ns-223.awsdns-27.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
    ]
    zone_id = "Z1048411IND1D7U817GK"
}

resource "aws_lb" "ElasticLoadBalancingV2LoadBalancer" {
    name = "apl-humhub-ecs-fargate-service"
    internal = false
    load_balancer_type = "application"
    subnets = [
        "subnet-0a390dba7f2844740",
        "subnet-0ac95c2de31a38263"
    ]
    security_groups = [
        "${aws_security_group.EC2SecurityGroup2.id}"
    ]
    ip_address_type = "ipv4"
    access_logs {
        enabled = false
        bucket = ""
        prefix = ""
    }
    idle_timeout = "60"
    enable_deletion_protection = "false"
    enable_http2 = "true"
    enable_cross_zone_load_balancing = "true"
}

resource "aws_lb_listener" "ElasticLoadBalancingV2Listener" {
    load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:891856990808:loadbalancer/app/apl-humhub-ecs-fargate-service/76647e729d1ca177"
    port = 80
    protocol = "HTTP"
    default_action {
        target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:891856990808:targetgroup/gd-humhub-tecnoct/4544ee25f7a3bc9f"
        type = "forward"
    }
}

resource "aws_security_group" "EC2SecurityGroup" {
    description = "Permite enviar e receber emails da aplicacao humhub"
    name = "SG_email_humhub_tecnoct"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "${aws_vpc.EC2VPC.cidr_block}"
        ]
        from_port = 25
        protocol = "tcp"
        to_port = 25
    }
    ingress {
        cidr_blocks = [
            "${aws_vpc.EC2VPC.cidr_block}"
        ]
        from_port = 465
        protocol = "tcp"
        to_port = 465
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
    egress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup2" {
    description = "Grupo de Seguranca para o APL do Humhub"
    name = "SG_ELB_humhub"
    tags = {
        projeto = "projeto13_grupo06-humhub"
    }
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup3" {
    description = "Permite controlar o acesso ao endpoint"
    name = "security-group-vpc-endpoint-humhub-tecnoct"
    tags = {
        projeto = "projeto13_grupo06-humhub"
    }
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "${aws_vpc.EC2VPC.cidr_block}"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        cidr_blocks = [
            "${aws_vpc.EC2VPC.cidr_block}"
        ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
    egress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup4" {
    description = "Grupo de Seguranca para o APL do Humhub"
    name = "SG_ALB_humhub"
    tags = {
        projeto = "projeto13_grupo06-humhub"
    }
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/16"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/16"
        ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/16"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
    egress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup5" {
    description = "Created by RDS management console"
    name = "sg_db_TecnoCT"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "189.12.149.202/32"
        ]
        from_port = 3306
        protocol = "tcp"
        to_port = 3306
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 3306
        protocol = "tcp"
        to_port = 3306
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
    egress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup6" {
    description = "Security Group para tasks do humhub"
    name = "sg_web_humhub"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 8080
        protocol = "tcp"
        to_port = 8080
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 8080
        protocol = "tcp"
        to_port = 8080
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
    egress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_lb_target_group" "ElasticLoadBalancingV2TargetGroup" {
    health_check {
        interval = 30
        path = "/user/auth/login"
        port = "traffic-port"
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 2
        healthy_threshold = 5
        matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    name = "gd-humhub-tecnoct"
}

resource "aws_network_interface" "EC2NetworkInterface" {
    description = "arn:aws:ecs:us-east-1:891856990808:attachment/3243b7ea-0f3d-4e5d-bb15-2dd64b7a6559"
    private_ips = [
        "10.0.3.165"
    ]
    subnet_id = "subnet-073ccf2a4c31ad461"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup6.id}"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface2" {
    description = "ELB app/apl-humhub-ecs-fargate-service/76647e729d1ca177"
    private_ips = [
        "10.0.1.16"
    ]
    subnet_id = "subnet-0ac95c2de31a38263"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup2.id}"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface3" {
    description = "arn:aws:ecs:us-east-1:891856990808:attachment/f1f47f32-aecf-48d0-b045-900db0b9fcb9"
    private_ips = [
        "10.0.1.176"
    ]
    subnet_id = "subnet-0ac95c2de31a38263"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup6.id}"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface4" {
    description = "RDSNetworkInterface"
    private_ips = [
        "10.0.1.32"
    ]
    subnet_id = "subnet-0ac95c2de31a38263"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup5.id}"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface5" {
    description = "EFS mount target for fs-0dcdbf56073416b82 (fsmt-0852ce334db888836)"
    private_ips = [
        "10.0.3.250"
    ]
    subnet_id = "subnet-073ccf2a4c31ad461"
    source_dest_check = true
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface6" {
    description = "Interface for NAT Gateway nat-0e1fba3d48050974f"
    private_ips = [
        "10.0.1.165"
    ]
    subnet_id = "subnet-0ac95c2de31a38263"
    source_dest_check = false
}

resource "aws_network_interface" "EC2NetworkInterface7" {
    description = "EFS mount target for fs-00f3149623cd036ac (fsmt-09ec7e87fb3764df8)"
    private_ips = [
        "10.0.3.42"
    ]
    subnet_id = "subnet-073ccf2a4c31ad461"
    source_dest_check = true
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface8" {
    description = "Interface for NAT Gateway nat-0ac209202e621941e"
    private_ips = [
        "10.0.2.191"
    ]
    subnet_id = "subnet-0a390dba7f2844740"
    source_dest_check = false
}

resource "aws_network_interface" "EC2NetworkInterface9" {
    description = "EFS mount target for fs-00f3149623cd036ac (fsmt-065d7b0747ebe9654)"
    private_ips = [
        "10.0.4.100"
    ]
    subnet_id = "subnet-03501111fcb327952"
    source_dest_check = true
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface10" {
    description = "arn:aws:ecs:us-east-1:891856990808:attachment/d7a884f4-5618-44ed-9125-1af62db43c1d"
    private_ips = [
        "10.0.4.203"
    ]
    subnet_id = "subnet-03501111fcb327952"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup6.id}"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface11" {
    description = "arn:aws:ecs:us-east-1:891856990808:attachment/88722055-9e6c-4fa5-8a85-2530e5311e63"
    private_ips = [
        "10.0.2.145"
    ]
    subnet_id = "subnet-0a390dba7f2844740"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup6.id}"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface12" {
    description = "EFS mount target for fs-0dcdbf56073416b82 (fsmt-036f7bc2fc071c1b3)"
    private_ips = [
        "10.0.4.110"
    ]
    subnet_id = "subnet-03501111fcb327952"
    source_dest_check = true
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
}

resource "aws_network_interface" "EC2NetworkInterface13" {
    description = "ELB app/apl-humhub-ecs-fargate-service/76647e729d1ca177"
    private_ips = [
        "10.0.2.106"
    ]
    subnet_id = "subnet-0a390dba7f2844740"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup2.id}"
    ]
}

resource "aws_db_instance" "RDSDBInstance" {
    identifier = "database-tecnoct"
    allocated_storage = 50
    instance_class = "db.t3.micro"
    engine = "mysql"
    username = "root"
    password = "REPLACEME"
    name = "db_humhub"
    backup_window = "07:09-07:39"
    backup_retention_period = 0
    availability_zone = "us-east-1a"
    maintenance_window = "sat:04:21-sat:04:51"
    multi_az = false
    engine_version = "8.0.33"
    auto_minor_version_upgrade = true
    license_model = "general-public-license"
    iops = 3000
    publicly_accessible = true
    storage_type = "gp3"
    port = 3306
    storage_encrypted = true
    kms_key_id = "arn:aws:kms:us-east-1:891856990808:key/9dea037f-b697-4b43-9660-38f751474c41"
    copy_tags_to_snapshot = true
    monitoring_interval = 0
    iam_database_authentication_enabled = false
    deletion_protection = false
    db_subnet_group_name = "default-vpc-020acd05d5abbd94c"
    vpc_security_group_ids = [
        "${aws_security_group.EC2SecurityGroup5.id}"
    ]
    max_allocated_storage = 1000
}

resource "aws_db_subnet_group" "RDSDBSubnetGroup" {
    description = "Created from the RDS Management Console"
    name = "default-vpc-020acd05d5abbd94c"
    subnet_ids = [
        "subnet-073ccf2a4c31ad461",
        "subnet-0a390dba7f2844740",
        "subnet-0ac95c2de31a38263",
        "subnet-03501111fcb327952"
    ]
}

resource "aws_opsworks_user_profile" "OpsWorksUserProfile" {
    allow_self_management = false
    user_arn = "arn:aws:iam::891856990808:user/heitorlourenco_CLI"
    ssh_username = "heitorlourenco_cli"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm" {
    alarm_name = "TargetTracking-service/ecs-fargate-humhub-cluster/service-fargate-humhub-tecnoct-AlarmHigh-1229205f-77a0-4284-ab37-ce7825bc1393"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:891856990808:scalingPolicy:043b8f99-e8be-4519-871a-48ddefa403b1:resource/ecs/service/ecs-fargate-humhub-cluster/service-fargate-humhub-tecnoct:policyName/policy_humhub_cpu_utilization:createdBy/0a09cedf-4ec2-410f-b39e-6f3b3e2749c7."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:891856990808:scalingPolicy:043b8f99-e8be-4519-871a-48ddefa403b1:resource/ecs/service/ecs-fargate-humhub-cluster/service-fargate-humhub-tecnoct:policyName/policy_humhub_cpu_utilization:createdBy/0a09cedf-4ec2-410f-b39e-6f3b3e2749c7"
    ]
    metric_name = "CPUUtilization"
    namespace = "AWS/ECS"
    statistic = "Average"
    dimensions {
        ClusterName = "ecs-fargate-humhub-cluster"
        ServiceName = "service-fargate-humhub-tecnoct"
    }
    period = 60
    unit = "Percent"
    evaluation_periods = 3
    threshold = 50
    comparison_operator = "GreaterThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm2" {
    alarm_name = "TargetTracking-service/ecs-fargate-humhub-cluster/service-fargate-humhub-tecnoct-AlarmLow-1546069a-ebee-4c0a-9f0d-a00e33a7f29d"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:891856990808:scalingPolicy:043b8f99-e8be-4519-871a-48ddefa403b1:resource/ecs/service/ecs-fargate-humhub-cluster/service-fargate-humhub-tecnoct:policyName/policy_humhub_cpu_utilization:createdBy/0a09cedf-4ec2-410f-b39e-6f3b3e2749c7."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:891856990808:scalingPolicy:043b8f99-e8be-4519-871a-48ddefa403b1:resource/ecs/service/ecs-fargate-humhub-cluster/service-fargate-humhub-tecnoct:policyName/policy_humhub_cpu_utilization:createdBy/0a09cedf-4ec2-410f-b39e-6f3b3e2749c7"
    ]
    metric_name = "CPUUtilization"
    namespace = "AWS/ECS"
    statistic = "Average"
    dimensions {
        ClusterName = "ecs-fargate-humhub-cluster"
        ServiceName = "service-fargate-humhub-tecnoct"
    }
    period = 60
    unit = "Percent"
    evaluation_periods = 15
    threshold = 45
    comparison_operator = "LessThanThreshold"
}

resource "aws_cloudwatch_log_group" "LogsLogGroup" {
    name = "/aws/ecs/containerinsights/ecs-fargate-humhub-cluster/performance"
    retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "LogsLogGroup2" {
    name = "/ecs/task-definition-fargate-aurora-humhubr"
}

resource "aws_cloudwatch_log_group" "LogsLogGroup3" {
    name = "/ecs/task-definition-fargate-humhubr"
}

resource "aws_ecr_repository" "ECRRepository" {
    name = "projeto_humhub"
}

resource "aws_ecs_cluster" "ECSCluster" {
    name = "ecs-fargate-humhub-cluster"
}

resource "aws_ecs_service" "ECSService" {
    name = "service-fargate-humhub-tecnoct"
    cluster = "arn:aws:ecs:us-east-1:891856990808:cluster/ecs-fargate-humhub-cluster"
    load_balancer {
        target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:891856990808:targetgroup/gd-humhub-tecnoct/4544ee25f7a3bc9f"
        container_name = "ecr-image-humhub"
        container_port = 80
    }
    desired_count = 2
    platform_version = "LATEST"
    task_definition = "${aws_ecs_task_definition.ECSTaskDefinition.arn}"
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 100
    iam_role = "arn:aws:iam::891856990808:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
    network_configuration {
        assign_public_ip = "DISABLED"
        security_groups = [
            "${aws_security_group.EC2SecurityGroup6.id}"
        ]
        subnets = [
            "subnet-073ccf2a4c31ad461",
            "subnet-03501111fcb327952"
        ]
    }
    health_check_grace_period_seconds = 0
    scheduling_strategy = "REPLICA"
}

resource "aws_ecs_task_definition" "ECSTaskDefinition" {
    container_definitions = "[{\"name\":\"ecr-image-humhub\",\"image\":\"891856990808.dkr.ecr.us-east-1.amazonaws.com/projeto_humhub\",\"cpu\":0,\"portMappings\":[{\"containerPort\":80,\"hostPort\":80,\"protocol\":\"tcp\"}],\"essential\":true,\"environment\":[{\"name\":\"HUMHUB_DB_USER\",\"value\":\"root\"},{\"name\":\"HUMHUB_DB_HOST\",\"value\":\"database-tecnoct.c7opo5blmqwb.us-east-1.rds.amazonaws.com\"},{\"name\":\"HUMHUB_DB_NAME\",\"value\":\"db_humhub\"},{\"name\":\"HUMHUB_AUTO_INSTALL\",\"value\":\"0\"},{\"name\":\"HUMHUB_ADMIN_PASSWORD\",\"value\":\"admin\"},{\"name\":\"HUMHUB_DB_PASSWORD\",\"value\":\"humhub2023\"},{\"name\":\"HUMHUB_ADMIN_EMAIL\",\"value\":\"humhub@humhub.com\"},{\"name\":\"HUMHUB_ADMIN_LOGIN\",\"value\":\"admin\"}],\"environmentFiles\":[],\"mountPoints\":[{\"sourceVolume\":\"config\",\"containerPath\":\"/var/www/localhost/htdocs/protected/config\",\"readOnly\":false},{\"sourceVolume\":\"uploads\",\"containerPath\":\"/var/www/localhost/htdocs/uploads\",\"readOnly\":false},{\"sourceVolume\":\"modules\",\"containerPath\":\"/var/www/localhost/htdocs/protected/modules\",\"readOnly\":false}],\"volumesFrom\":[],\"ulimits\":[],\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-create-group\":\"true\",\"awslogs-group\":\"/ecs/task-definition-fargate-humhubr\",\"awslogs-region\":\"us-east-1\",\"awslogs-stream-prefix\":\"ecs\"},\"secretOptions\":[]}}]"
    family = "task-definition-fargate-humhubr"
    execution_role_arn = "${aws_iam_role.IAMRole2.arn}"
    network_mode = "awsvpc"
    volume {
        name = "config"
    }
    volume {
        name = "uploads"
    }
    volume {
        name = "modules"
    }
    requires_compatibilities = [
        "FARGATE"
    ]
    cpu = "1024"
    memory = "2048"
}

resource "aws_ecs_task_definition" "ECSTaskDefinition2" {
    container_definitions = "[{\"name\":\"container-humhub-aurora\",\"image\":\"mriedmann/humhub:stable\",\"cpu\":0,\"portMappings\":[{\"containerPort\":80,\"hostPort\":80,\"protocol\":\"tcp\"}],\"essential\":true,\"environment\":[{\"name\":\"HUMHUB_DB_USER\",\"value\":\"humhub\"},{\"name\":\"HUMHUB_DB_HOST\",\"value\":\"mysql-5-7-43.cizo1euc0jqz.us-east-2.rds.amazonaws.com\"},{\"name\":\"HUMHUB_DB_NAME\",\"value\":\"humhub\"},{\"name\":\"HUMHUB_AUTO_INSTALL\",\"value\":\"0\"},{\"name\":\"HUMHUB_ADMIN_PASSWORD\",\"value\":\"admin\"},{\"name\":\"HUMHUB_DB_PASSWORD\",\"value\":\"humhub123\"},{\"name\":\"HUMHUB_ADMIN_EMAIL\",\"value\":\"humhub@humhub.com\"},{\"name\":\"HUMHUB_ADMIN_LOGIN\",\"value\":\"admin\"}],\"environmentFiles\":[],\"mountPoints\":[{\"sourceVolume\":\"config\",\"containerPath\":\"/var/www/localhost/htdocs/protected/config\",\"readOnly\":false},{\"sourceVolume\":\"uploads\",\"containerPath\":\"/var/www/localhost/htdocs/uploads\",\"readOnly\":false},{\"sourceVolume\":\"modules\",\"containerPath\":\"/var/www/localhost/htdocs/protected/modules\",\"readOnly\":false}],\"volumesFrom\":[],\"ulimits\":[],\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-create-group\":\"true\",\"awslogs-group\":\"/ecs/task-definition-fargate-aurora-humhubr\",\"awslogs-region\":\"us-east-1\",\"awslogs-stream-prefix\":\"ecs\"},\"secretOptions\":[]}}]"
    family = "task-definition-fargate-aurora-humhubr"
    task_role_arn = "${aws_iam_role.IAMRole2.arn}"
    execution_role_arn = "${aws_iam_role.IAMRole2.arn}"
    network_mode = "awsvpc"
    volume {
        name = "config"
    }
    volume {
        name = "uploads"
    }
    volume {
        name = "modules"
    }
    requires_compatibilities = [
        "FARGATE"
    ]
    cpu = "1024"
    memory = "2048"
}

resource "aws_efs_file_system" "EFSFileSystem" {
    performance_mode = "generalPurpose"
    encrypted = true
    kms_key_id = "arn:aws:kms:us-east-1:891856990808:key/b7ae2764-a87a-4745-bfef-58c19f06fc35"
    throughput_mode = "elastic"
    tags = {
        Name = "EFS-Aurora"
    }
}

resource "aws_efs_file_system" "EFSFileSystem2" {
    performance_mode = "generalPurpose"
    encrypted = true
    kms_key_id = "arn:aws:kms:us-east-1:891856990808:key/b7ae2764-a87a-4745-bfef-58c19f06fc35"
    throughput_mode = "elastic"
    tags = {
        Name = "efs-humhub"
    }
}

resource "aws_efs_mount_target" "EFSMountTarget" {
    file_system_id = "fs-00f3149623cd036ac"
    ip_address = "10.0.4.100"
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
    subnet_id = "subnet-03501111fcb327952"
}

resource "aws_efs_mount_target" "EFSMountTarget2" {
    file_system_id = "fs-00f3149623cd036ac"
    ip_address = "10.0.3.42"
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
    subnet_id = "subnet-073ccf2a4c31ad461"
}

resource "aws_efs_mount_target" "EFSMountTarget3" {
    file_system_id = "fs-0dcdbf56073416b82"
    ip_address = "10.0.4.110"
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
    subnet_id = "subnet-03501111fcb327952"
}

resource "aws_efs_mount_target" "EFSMountTarget4" {
    file_system_id = "fs-0dcdbf56073416b82"
    ip_address = "10.0.3.250"
    security_groups = [
        "sg-00cac7cbb14e0853c"
    ]
    subnet_id = "subnet-073ccf2a4c31ad461"
}

resource "aws_neptune_subnet_group" "NeptuneDBSubnetGroup" {
    name = "default-vpc-020acd05d5abbd94c"
    description = "Created from the RDS Management Console"
    subnet_ids = [
        "subnet-073ccf2a4c31ad461",
        "subnet-0a390dba7f2844740",
        "subnet-0ac95c2de31a38263",
        "subnet-03501111fcb327952"
    ]
}

resource "aws_docdb_subnet_group" "DocDBDBSubnetGroup" {
    name = "default-vpc-020acd05d5abbd94c"
    description = "Created from the RDS Management Console"
    subnet_ids = [
        "subnet-073ccf2a4c31ad461",
        "subnet-0a390dba7f2844740",
        "subnet-0ac95c2de31a38263",
        "subnet-03501111fcb327952"
    ]
}

resource "aws_service_discovery_http_namespace" "ServiceDiscoveryHttpNamespace" {
    name = "ecs-fargate-humhub-cluster"
}

resource "aws_backup_vault" "BackupBackupVault" {
    name = "aws/efs/automatic-backup-vault"
    kms_key_arn = "arn:aws:kms:us-east-1:891856990808:key/a0cfa42e-a750-42d1-b048-6522a6eeba69"
}

resource "aws_backup_plan" "BackupBackupPlan" {
    name = "aws/efs/automatic-backup-plan"
    rule {
        completion_window = 10080
        lifecycle {
            delete_after = 35
        }
        rule_name = "aws/efs/automatic-backup-rule"
        schedule = "cron(0 5 ? * * *)"
        start_window = 480
        target_vault_name = "aws/efs/automatic-backup-vault"
    }
}

resource "aws_backup_selection" "BackupBackupSelection" {
    plan_id = "aws/efs/73d922fb-9312-3a70-99c3-e69367f9fdad"
    name = "aws/efs/automatic-backup-selection"
    iam_role_arn = "arn:aws:iam::891856990808:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup"
    selection_tag {
        type = "STRINGEQUALS"
        key = "aws:elasticfilesystem:default-backup"
        value = "enabled"
    }
}
