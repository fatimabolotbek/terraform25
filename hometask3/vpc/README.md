## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.28.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | Availability Zones | `list(string)` | <pre>[<br/>  "us-east-2a",<br/>  "us-east-2b",<br/>  "us-east-2c"<br/>]</pre> | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | Private subnet CIDR blocks | `list(string)` | <pre>[<br/>  "10.0.3.0/24",<br/>  "10.0.4.0/24",<br/>  "10.0.5.0/24"<br/>]</pre> | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | Public subnet CIDR blocks | `list(string)` | <pre>[<br/>  "10.0.0.0/24",<br/>  "10.0.1.0/24",<br/>  "10.0.2.0/24"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | command tage | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "Name": "homework3-vpc"<br/>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | n/a |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | n/a |
| <a name="output_private_route_table_id"></a> [private\_route\_table\_id](#output\_private\_route\_table\_id) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |



What is count?
count tells Terraform: **create multiple copies of the same resource**.

Example:
resource "aws_subnet" "public" {
  count = 3
}

This creates:
aws_subnet.public[0]
aws_subnet.public[1]
aws_subnet.public[2]

What is length()?
length() returns how many items are in a list.
Example:
length(var.public_subnet_cidrs)
If your variable contains 3 CIDRs, length() returns 3.
Why we use count = length(...) together
Because we want Terraform to automatically create one subnet per CIDR.

Example:

count      = length(var.public_subnet_cidrs)
cidr_block = var.public_subnet_cidrs[count.index]


This means:
subnet[0] uses CIDR #1
subnet[1] uses CIDR #2
subnet[2] uses CIDR #

What is count.index?
count.index is the current number in the loop:
first resource: 0
second: 1
third: 2

So this line:
availability_zone = var.azs[count.index]
means each subnet goes into a matching AZ
////////////
When to use count (use cases)
Use count when:
You have a list and want to create multiple similar resources
multiple subnets
multiple route table associations
multiple security group rules
multiple EC2 instances (same template)
Example use cases in this repo:
Create 3 public subnets from var.public_subnet_cidrs
Create 3 private subnets from var.private_subnet_cidrs
Associate each public subnet to the public route table
///////////
Requirement (very important)
The list lengths must match for AZ mapping:
public_subnet_cidrs length = 3
private_subnet_cidrs length = 3
azs length = 3
If AZ list is shorter, Terraform will fail with index errors.