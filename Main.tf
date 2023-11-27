resource "aws_key_pair" "mykey" {
    key_name = "manu-demo-key"
    public_key = "~/.ssh/id_rsa"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
  
}

resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "myrta" {
    subnet_id = aws_subnet.mysubnet.id
    route_table_id = aws_route_table.myrt.id
  
}

resource "aws_security_group" "mysg" {
    name = "web"
    vpc_id = aws_vpc.myvpc.id

     ingress {
        description  = "HTTP from the vpc"
        from_port    = 80
        to_port      = 80
        protocol     = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }
     ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }
     egress  {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
     }
    
}

resource "aws_instance" "myinstance" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.mysg.id]
    subnet_id = aws_subnet.mysubnet.id
    key_name = aws_key_pair.mykey.id

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
      timeout = "2m"
      agent = false
    } 

    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
      
    }

    provisioner "remote-exec" {
        inline = [ 
            "set -x",
            "echo 'Hello from the remote instance'",
            "sudo apt update -y",
            "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "sudo pip3 install flask",
            "sudo python3 app.py"
         ]
      
    }
}
