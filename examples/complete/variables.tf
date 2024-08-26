variable "region" {
    default = "eu-west-1"
    type = string
    description = "The region used to deploy the ec2 instance"
}
variable "ami_id" {
    default = "ami-0dafe364659bd5eb6"
    description = "The windows ami id"
    type = string
}
variable "instance_type" {
    default = "t2.micro"
    description = "The machine type (resource etc...)"
    type = string
}
variable "instance_name" {
    default = "windows-server"
    description = "The server name"
    type = string
}
variable "key_name" {
    default = "key_name"
    description = "Key used to connect to the machine"
}
variable "windows-sg" {
    default = "windows-sg"
    description = "create security group for the machine so we can connect"
}
variable "windows-features" {
    default = "Web-Server" 
    description = "A list of all the windows feature we want to install * seperated by ,"
    type = string
  
}
variable "ingress-port" {
    default = 3389
    type = string
    description = "The port we use to connect to the windows host"
  
}