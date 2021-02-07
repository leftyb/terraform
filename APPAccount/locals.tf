variable "variable" {
  type = map
  default = {
    prod    = "prod"
  }
}

variable "clusterName"{
  type = string
}

variable "ci_cd_account_number" {
  type      = string
  default   =""
}



locals {
  tags = {
    "Name"        = "Network"
    "Owner"       = "Maher Fayez"
    "Email"       = "maher.mfayez@gmail.com"
    "Environment" = "ci-cd"
    "GithubRepo"  = "https://github.com/xxx/"
    "Customer"    = "Network"
    "Project"     = "POC"
    "Product"     = "Network"
  } 
  web_tag = {
    "Name"      = "app"
    "Product"   = "contoso"
 }
}
