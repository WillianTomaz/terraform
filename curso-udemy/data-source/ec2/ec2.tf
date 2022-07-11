resource "aws_instance" "my-instance" {
  ami          = data.aws_ami.ubuntu.id
  instace_type = var.instace_type
}