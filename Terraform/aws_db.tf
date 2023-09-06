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

