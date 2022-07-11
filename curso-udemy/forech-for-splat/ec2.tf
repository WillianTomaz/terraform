data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    valeus = ["x84_64"]
  }
}


resource "aws_instance" "this" {
  for_each = {
    web = {
      name = "Web server"
      type = "t3.medium"
    }
    ci_cd = {
      name = "Web server"
      type = "t3.micro"
    }
  }

  ami           = data.aws_ami.ubuntu
  instance_type = lookup(each.value, "type", null)

  tags = {
    "Project" = "Curso Terraform"
    "Name"    = "${each.key}: ${lookup(each.value, "name", null)}"
    Lesson    = "Forech, For, Splat"
  }
}