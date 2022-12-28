resource "aws_instance" "dbserver" {
  ami = "ami-0f924dc71d44d23e2"
  instance_type = "t2.micro"

  tags = {
    "AutoOff" = "True"
    "Owner" = "Samantha"
    "Name" = "DB Server"
  }
}

output "dbprivateip" {
  value = aws_instance.dbserver.private_ip  
}