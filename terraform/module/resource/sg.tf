resource "aws_security_group" "loadbalancer" {
  name        = "Allow-all-loadbalance-traffic"
  description = "Allow traffic on public VM"
  vpc_id      = var.vpc.id

  dynamic "ingress" {
    for_each = var.loadbalancer_ports
    content {
      description = "Allow ${ingress.value} inbound traffic"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_all" {
  #Create a security group for each instance
  for_each    = var.instance
  name        = "allow_${each.key}"
  description = "Allow ${each.key} inbound and all outbound traffic"
  vpc_id      = var.vpc.id

  tags = {
    Name      = "allow_${each.key}"
    "Project" = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ipv4" {
  #Create an inbound traffic rule to allow the ports specified for each var.instance

  /* the for_each is a nested for statement. for_each = var.instance is the same as for_each = [for instance in var.instance : instance]
  1. The first for statement is in {} (this creates a map), because a for_each can only handle map, object, sets, but not lists or tuples.
  2. The first for statement takes the index and the values from a tuple. A tuple is created with flatten(), because var.instance is a nested variable. flatten() is used to make a flat hierarchy instead of having lists inside lists inside lists, which would make it difficult to retrieve data
  3. The for statements in flatten() retrieve the key and the ports and make an object for each pair. The name of each object is a combination of the keyname and portname to create a unique identifier.
  The for each will go over each object.
  */
  for_each = { for i, instance in flatten([for name, instance in var.instance : [for port in instance.port_numbers : { name = name, port = port }]]) : "${instance.name}-${instance.port}" => {
    name = instance.name
    port = instance.port
    }
  }

  security_group_id = aws_security_group.allow_all[each.value.name].id
  description       = "Allow ${each.value.name} inbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "TCP"
  from_port         = each.value.port
  to_port           = each.value.port
  tags = {
    Name      = "allow_${each.value.name}_ipv4"
    "Project" = var.project_name
  }
}



resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  # Create an outbound traffic rule for each instance with allow all
  for_each          = var.instance
  security_group_id = aws_security_group.allow_all[each.key].id
  description       = "Allow all outbound traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  tags = {
    Name      = "allow_all_ipv4"
    "Project" = var.project_name
  }

}