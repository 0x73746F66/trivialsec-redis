resource "random_string" "redis_password" {
    length  = 32
    special = false
}
resource "random_string" "linode_redis_password" {
    length  = 32
    special = true
}
resource "linode_instance" "redis" {
  label             = local.redis_hostname
  group             = "SaaS"
  tags              = ["Database", "Shared"]
  region            = local.linode_default_region
  type              = local.linode_default_type
  image             = local.linode_default_image
  authorized_keys   = length(var.public_key) == 0 ? [] : [
    var.public_key
  ]
  authorized_users  = length(var.allowed_linode_username) == 0 ? [] : [
    var.allowed_linode_username
  ]
  root_pass         = random_string.linode_redis_password.result
  stackscript_id    = linode_stackscript.redis.id
  stackscript_data  = {
    "FQDN"                  = local.redis_hostname
    "REDIS_PASSWORD"        = random_string.redis_password.result
    "REDIS_PORT"            = 6379
    "AWS_REGION"            = local.aws_default_region
    "AWS_ACCESS_KEY_ID"     = var.aws_access_key_id
    "AWS_SECRET_ACCESS_KEY" = var.aws_secret_access_key
  }
  alerts {
      cpu            = 90
      io             = 10000
      network_in     = 10
      network_out    = 10
      transfer_quota = 80
  }
}
output "redis_id" {
  value = linode_instance.redis.id
}
output "redis_ipv4" {
  value = [for ip in linode_instance.redis.ipv4 : join("/", [ip, "32"])]
}
output "redis_ipv6" {
  value = linode_instance.redis.ipv6
}
output "redis_password" {
  sensitive = true
  value = random_string.redis_password.result
}
output "redis_linode_password" {
  sensitive = true
  value = random_string.linode_redis_password.result
}
