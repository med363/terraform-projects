variable "region" {
    description =   "AWS region to depoy to"
    type    =   string
    default  =  "eu-north-1"
}

variable "site_name" {
    description =   "Name prefix for the s3 bucket"
    type    =   string
    default   =  "website-bucket"
}