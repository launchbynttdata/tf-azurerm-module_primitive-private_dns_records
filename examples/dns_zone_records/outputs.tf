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

output "a_record_ids" {
  value       = module.dns_records.a_record_ids
  description = "The DNS A Record IDs."
}

output "a_record_fqdns" {
  value       = module.dns_records.a_record_fqdns
  description = "The FQDNs of the DNS A Records."
}

output "cname_record_ids" {
  value       = module.dns_records.cname_record_ids
  description = "The DNS CNAME Record IDs."
}

output "cname_record_fqdns" {
  value       = module.dns_records.cname_record_fqdns
  description = "The FQDNs of the DNS CNAME Records."
}

output "txt_record_ids" {
  value       = module.dns_records.txt_record_ids
  description = "The DNS TXT Record IDs."
}

output "txt_record_fqdns" {
  value       = module.dns_records.txt_record_fqdns
  description = "The FQDNs of the DNS TXT Records."
}

output "resource_group_name" {
  value       = module.resource_group.name
  description = "The name of the resource group."
}

output "private_dns_zone_name" {
  value       = var.zone_name
  description = "The names of the private DNS zone."
}
