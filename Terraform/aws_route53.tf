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

