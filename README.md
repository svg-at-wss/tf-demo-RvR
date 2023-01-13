# tf-demo-RvR

This is a very basic terraform project that invokes modules in three ways:

1. A module is built as a submodule of the project itself
2. A module is included from the public aws security-group module that exists in the tf registry
3. A module is included from a private registry (tf cloud registry)

This project uses the aws provider


----

This project will demonstrate how Renovate via Remediate deals with tf projects by using both the `terraform-modules` and `terraform-providers` datasources.

---

# Private Registry Auth and Renovate

customModule1 is a private module that lives on a private registry (terraform cloud). The project initially calls v1.0.0 to demonstrate that Renovate will find an update version available, regardless of the Renovate max/min/patch version rules in place. There are several versions available in the terraform registry.

The .whitesource file has been configured to matchHost at the terraform cloud url, and authenticate using my username and an encrypted API token, generated on TFC.