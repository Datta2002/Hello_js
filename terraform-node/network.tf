resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "hello-world-vpc"
  }
}

resource "aws_subnet" "main_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.31.16.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "hello-world-subnet-a"
  }
}

resource "aws_subnet" "main_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.31.32.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "hello-world-subnet-b"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "hello-world-igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "hello-world-route-table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "main_a" {
  subnet_id      = aws_subnet.main_a.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "main_b" {
  subnet_id      = aws_subnet.main_b.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "ecs" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "hello-world-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
