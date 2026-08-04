# tf-azurerm-module_primitive-private_dns_records

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module creates the records of type A, CNAME, and TXT for private DNS zone.

## Usage

See [examples/complete](examples/complete) for a full working example.

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines `pre-commit` hooks for Terraform formatting, validation, documentation generation, and detect-secrets. Hooks are installed when you run `make configure`. Go linting runs via `make lint` in local development and CI, not via pre-commit.

### Terratest examples

Post-deploy tests in `tests/post_deploy_functional/` and `tests/post_deploy_functional_readonly/` target `examples/complete` via an explicit folder constant in each `main_test.go`. Adding another example (for example `examples/minimal`) requires a new test entry point or updating that constant; it is not picked up automatically.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.
2. Ensure you are signed into the appropriate cloud provider (e.g. Azure) for the module under test in your current console session.
3. Run the Terraform and Golang linters:

```
make lint
```

4. Once linters pass, run integration tests (apply, test, destroy):

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, are performed in CI. Running them locally before opening a PR helps ensure a smooth review.

### Review & Merge Process

Open a Pull Request to the default (`main`) branch. The PR title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format to merge and to drive semantic versioning.

Ensure CI workflows pass, address review feedback, and obtain approvals required by `CODEOWNERS`.

### Automatic Updates

Shared configuration and workflow files are largely managed through [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). Avoid one-off edits to copied skeleton files in this repository unless necessary (for example `.gitignore` entries for generated artifacts). Use `copier check-update` / `copier update` when refreshing from the skeleton.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_a_record.a_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_cname_record.cname_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_txt_record.txt_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | A list of A records to create | <pre>map(object({<br/>    name                = string<br/>    resource_group_name = string<br/>    zone_name           = string<br/>    ttl                 = number<br/>    records             = list(string)<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | A list of A records to create | <pre>map(object({<br/>    name                = string<br/>    resource_group_name = string<br/>    zone_name           = string<br/>    ttl                 = number<br/>    record              = optional(string)<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | A list of A records to create | <pre>map(object({<br/>    name                = string<br/>    resource_group_name = string<br/>    zone_name           = string<br/>    ttl                 = number<br/>    records             = list(string)<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_a_record_fqdns"></a> [a\_record\_fqdns](#output\_a\_record\_fqdns) | The FQDNs of the DNS A Records. |
| <a name="output_a_record_ids"></a> [a\_record\_ids](#output\_a\_record\_ids) | The DNS A Record IDs. |
| <a name="output_cname_record_fqdns"></a> [cname\_record\_fqdns](#output\_cname\_record\_fqdns) | The FQDNs of the DNS CNAME Records. |
| <a name="output_cname_record_ids"></a> [cname\_record\_ids](#output\_cname\_record\_ids) | The DNS CNAME Record IDs. |
| <a name="output_txt_record_fqdns"></a> [txt\_record\_fqdns](#output\_txt\_record\_fqdns) | The FQDNs of the DNS TXT Records. |
| <a name="output_txt_record_ids"></a> [txt\_record\_ids](#output\_txt\_record\_ids) | The DNS TXT Record IDs. |
<!-- END_TF_DOCS -->
