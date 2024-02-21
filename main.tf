// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_private_dns_a_record" "a_record" {
  for_each = var.a_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  zone_name = each.value.zone_name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = local.tags[each.key]
}

resource "azurerm_private_dns_cname_record" "cname_record" {
  for_each = var.cname_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  zone_name = each.value.zone_name
  ttl       = each.value.ttl
  record    = each.value.record
  tags      = local.tags[each.key]
}

resource "azurerm_private_dns_txt_record" "txt_record" {
  for_each = var.txt_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  zone_name = each.value.zone_name
  ttl       = each.value.ttl
  tags      = local.tags[each.key]
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}
