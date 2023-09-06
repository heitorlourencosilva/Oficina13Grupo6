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
