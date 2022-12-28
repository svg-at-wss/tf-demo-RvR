provider "aws" {
  region = "us-east-2"
}

# Private module, exists within the project
module "db_module" {
  source = "./db"
  
}

# Public module1; public, but remote tf registry, tfaws demo modules
module "security-group_demo_mod1" {
  source  = "terraform-aws-modules/security-group/aws//examples/complete"
  version = "4.15.0"
}

# Public module2; public, but remote tf registry, tfaws demo modules
module "security-group_demo_mod2" {
  source  = "terraform-aws-modules/security-group/aws//examples/rules-only"
  version = "4.15.0"
}

output "PrivateIP_DB" {
  value = module.db_module.dbprivateip
}

output "DemoMod_sgdesc" {
  value = module.security-group_demo_mod1.security_group_description
}


output "DemoMod_service-one-arn" {
  value = module.security-group_demo_mod2.service_one_security_group_arn
}