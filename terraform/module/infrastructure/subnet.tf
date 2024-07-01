data "aws_availability_zones" "filter_region" {
  #Retrieve all available availability zones in the specified region.
  state = "available"
  filter {
    name   = "group-name"
    values = [var.region]
  }
}

resource "aws_subnet" "main" {
  count = var.subnet_count

  vpc_id = aws_vpc.main.id

  #Get the cidr_block from the vpc, move the netmask with 8 bits and specify the networknumber(countindex 1 will get networknumber 1)
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 1)

  #Places each subnet in a different availability zone, as long as the retrieved list of availability zones allows it (Will start with availability zone a again when the amount of subnets outgrows the list of available availability zones.)
  availability_zone = data.aws_availability_zones.filter_region.names[count.index % length(data.aws_availability_zones.filter_region.names)]

  #The subnets are public for testing purposes, but will be private
  map_public_ip_on_launch = true

  tags = {
    Name      = "subnet${count.index + 1}"
    "Project" = var.project_name
  }

}