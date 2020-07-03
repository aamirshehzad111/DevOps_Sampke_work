output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_security_group_id" {
  value = aws_security_group.public_subnet_SG.id
}

output "dmz_security_group_id" {
  value = aws_security_group.dmz_subnet_SG.id
}

# it would list down tall the public subnets, you can use that list or can choose one from list by specifying index like: public_subnets[0]
output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

# it would list down tall the dmz subnets, you can use that list or can choose one from list by specifying index like: public_subnets[0]
output "DMZ_subnets" {
  value = aws_subnet.DMZ_subnet.*.id
}

# it would list down tall the public subnets, you can use that list or can choose one from list by specifying index like: public_subnets[0]
output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "vpc_default_security_group_id" {
  value = aws_vpc.vpc.default_security_group_id
}