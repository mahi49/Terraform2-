module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}resource "aws_eip" "nat" {
  count = 3

  vpc = true
}resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}  
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
} 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route = []

  tags = {
    Name = "publicrouttable"
  }
} 
resource "aws_route_table" "Private" {
  vpc_id = aws_vpc.example.id

  route = []

  tags = {
    Name = "privste routtable"
  }
} 
resource "aws_route_table_association" "Public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.piblic.id
} 
resource "aws_route_table_association" "privagte" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
