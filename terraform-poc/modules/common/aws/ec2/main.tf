resource "aws_instance" "frontend" {
  ami           = var.ami_ec2
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id       = var.subnets_id[count.index]
  security_groups = list("${var.sg_id}")

  #  user_data = <<-EOF
  #            #!/bin/bash
  #            echo "Ping from instance" > index.html
  #            nohup busybox httpd -f -p 8080 &
  #            echo "Ping from instance" > index.html
  #            nohup busybox httpd -f -p 3000 &
  #            EOF

  tags = {
    Name = var.instance_name
  }
  #
  #  provisioner "remote-exec" {
  #    inline = ["echo 'Hello world'"]
  #
  #    connection {
  #      host = self.public_ip
  #      type = "ssh"
  #      user = var.ssh_user
  #      private_key = file("~/.ssh/${var.key_name}")
  #    }
  #  }
  #
  #  provisioner "local-exec" {
  #    command = "ansible-playbook  -i ${self.public_ip}, --private-key ~/.ssh/${var.key_name} ../../../ansible/deploy-frontend.yml"
  #  }
  #
  count = var.nb_instance
}
