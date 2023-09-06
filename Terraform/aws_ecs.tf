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

resource "aws_service_discovery_http_namespace" "ServiceDiscoveryHttpNamespace" {
    name = "ecs-fargate-humhub-cluster"
}

