provider "aws" {
  region = var.region
}

module "website-bucket" {
  source    = "./modules/s3-static-site"
  site_name = var.site_name
  region    = var.region
  site_path = "${path.module}/site"
}
