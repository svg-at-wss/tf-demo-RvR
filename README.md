# tf-demo-RvR

This is a very basic terraform project that invokes modules in three ways:

1. A module is built as a submodule of the project itself
2. A module is included from the public aws security-group module that exists in the tf registry
3. A module is included from a private registry (jfrog or tf cloud registry)

This project uses the aws provider


----

This project will demonstrate how Renovate via Remediate deals with tf projects by using both the `terraform-modules` and `terraform-providers` datasources.