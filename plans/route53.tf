resource "aws_route53_record" "redis_a" {
    zone_id = local.route53_hosted_zone
    name    = local.redis_hostname
    type    = "A"
    ttl     = 300
    records = linode_instance.redis.ipv4
}
resource "aws_route53_record" "redis_aaaa" {
    zone_id = local.route53_hosted_zone
    name    = local.redis_hostname
    type    = "AAAA"
    ttl     = 300
    records = [
        element(split("/", linode_instance.redis.ipv6), 0)
    ]
}
