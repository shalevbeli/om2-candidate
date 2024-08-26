provider "aws" {
    region = var.region
}

resource "tls_private_key" "generate_public_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
    key_name = var.key_name
    public_key = tls_private_key.generate_public_key.public_key_openssh
}

resource "aws_security_group" "windows-sg" {
    name = var.windows-sg
    description = "Allow incoming connections"

    ingress {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming RDP connections"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name        = "${var.windows-sg}"
    }
}
resource "aws_instance" "my-server" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    
    get_password_data = true
    tags = {
        Name = var.instance_name
    }
    vpc_security_group_ids = [ aws_security_group.windows-sg.id ]

    user_data = <<EOF
    <powershell>
        # Setting the machine name
        $computername = ${var.instance_name};
        Rename-Computer -NewName $computername -Force;

        # Setting up the list of features to be installed
        $windowsFeatures = ${var.windows-features} -split ",";

        foreach ($feature in $windowsFeatures){
            Install-WindowsFeature -name $feature;
        }

        shutdown -r -t 5;
    </powershell>
    EOF
}