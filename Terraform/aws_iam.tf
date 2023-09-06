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

resource "aws_opsworks_user_profile" "OpsWorksUserProfile" {
    allow_self_management = false
    user_arn = "arn:aws:iam::891856990808:user/heitorlourenco_CLI"
    ssh_username = "heitorlourenco_cli"
}

