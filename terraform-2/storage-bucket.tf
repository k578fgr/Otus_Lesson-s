module "awesome_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "awesome"
  stage       = "production"
  namespace   = "sweetops"
  location    = "europe-west1"
}