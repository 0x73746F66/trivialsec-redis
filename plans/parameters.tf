resource "aws_ssm_parameter" "ssm_linode_redis_password" {
  name        = "/linode/${linode_instance.redis.id}/linode_redis_password"
  description = join(", ", linode_instance.redis.ipv4)
  type        = "SecureString"
  value       = random_string.linode_redis_password.result
  tags = {
    cost-center = "saas"
  }
}
resource "aws_ssm_parameter" "ssm_redis_password" {
  name        = "/Prod/Deploy/trivialsec/redis_password"
  description = join(", ", linode_instance.redis.ipv4)
  type        = "SecureString"
  value       = random_string.redis_password.result
  tags = {
    cost-center = "saas"
  }
}
