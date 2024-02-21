locals {
  default_tags = {
    "provisioner" = "terraform"
  }
  a_record_tags = {
    for k, v in var.a_records : k => merge(local.default_tags, { "resource_name" = v.name }, v.tags)
  }
  cname_record_tags = {
    for k, v in var.cname_records : k => merge(local.default_tags, { "resource_name" = v.name }, v.tags)
  }
  txt_record_tags = {
    for k, v in var.txt_records : k => merge(local.default_tags, { "resource_name" = v.name }, v.tags)
  }
  tags = merge(local.default_tags, local.a_record_tags, local.cname_record_tags, local.txt_record_tags)
}
