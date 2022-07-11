locals {
  records = {
    for name in var.domains :
    name => regex("^(?P<host>[^\\.]+)\\.(?P<domain>.+)$", name)
  }
}