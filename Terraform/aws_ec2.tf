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

