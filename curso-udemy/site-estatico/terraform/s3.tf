data "template_file" "s3-public-policy" {
  template = file("policy.json")
  vars     = { bucket_name = local.domain }
}

module "logs" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification"
  name          = "${local.domain}-logs"
  acl           = "log-delivery-write"
  force_destroy = !local.has_domain

  tags = local.common_tags
}

module "website" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification"
  name          = local.domain
  acl           = "public-read"
  policy        = data.template_file.s3-public-policy.rendered
  force_destroy = !local.has_domain

  versioning = {
    enabled = true
  }

  filepath = "${path.module}/../website/build"
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging = {
    target_bucket = module.logs.name
    target_prefix = "acess/"
  }

  tags = local.common_tags
}

module "redirect" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification"
  name          = "www.${local.domain}"
  acl           = "public-read"
  force_destroy = !local.has_domain

  website = {
    redirect_all_requests_to = local.has_domain ? var.domain : module.website.website
  }

  tags = local.common_tags
}
