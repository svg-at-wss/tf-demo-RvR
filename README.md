# tf-demo-RvR

This is a very basic terraform project that invokes modules in two ways:

1. A module is built as a submodule of the project itself
2. A module is called from the public aws security-group module that exists in the tf registry

This project uses the aws provider


----

This project will demonstrate how Renovate via Remediate deals with tf projects by using both the `terraform-modules` and `terraform-providers` datasources.