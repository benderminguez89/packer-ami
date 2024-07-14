/*
 - Packer build Ubuntu AMI
 - includes:
    - Base configurations
    - ...
*/

packer {
    required_plugins {
        aws = {
            version = " ~>=1"
            source = "github.com/hashicorp/amazon"
        }

        git = {
            version = " ~>=0.6.3"
            source = "~/workspace/projects/packer"
        }
    }
}

build {
    sources = ["source.amazon-ebs.ubuntu"]

    provisioner "ansible" {

    }
}
