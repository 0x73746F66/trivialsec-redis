data "local_file" "alpine_redis" {
    filename = "${path.root}/../bin/alpine-redis"
}
resource "linode_stackscript" "redis" {
  label = "redis"
  description = "Installs redis"
  script = data.local_file.alpine_redis.content
  images = [local.linode_default_image]
  rev_note = "initial version"
}
output "redis_stackscript_id" {
  value = linode_stackscript.redis.id
}
