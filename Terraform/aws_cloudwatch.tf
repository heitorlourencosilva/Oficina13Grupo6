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

