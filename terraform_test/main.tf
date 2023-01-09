module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "robin-example-2020-01-15"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
