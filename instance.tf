resource "aws_key_pair" "hoangviet88vn" {
    key_name                    = "hoangviet88vn"
    public_key                  = "${file("${var.key_path}/id_rsa.pub")}"
}
resource "aws_instance" "lab01" {
    ami                         =  "${lookup(var.amis , var.aws_region )}"
    instance_type               =  "t2.micro"
    key_name                    =  "hoangviet88vn"
    associate_public_ip_address =   true
    subnet_id                   =  "${aws_subnet.mysubnet01.id}"
    vpc_security_group_ids      =   ["${aws_security_group.mysg01.id}"]

    connection {
    type                        =  "ssh"
    user                        =  "ec2-user"
    private_key                 =  "${file("${var.key_path}/id_rsa")}"
    host                        =  self.public_ip
    }
    provisioner "remote-exec" {
    inline = ["uptime"]
    }
}