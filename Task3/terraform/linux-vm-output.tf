# Virtual Machines Module - Output ##

output "vm_ubuntu_server_instance_id" {
  value = aws_instance.ubuntu-server.id
}

output "vm_ubuntu_server_instance_public_dns" {
  value = aws_instance.ubuntu-server.public_dns
}

output "vm_ubuntu_server_instance_public_ip" {
  value = aws_eip.linux-eip-ubuntu.public_ip
}

output "vm_ubuntu_server_instance_private_ip" {
  value = aws_instance.ubuntu-server.private_ip
}

output "vm_centos_server_instance_id" {
  value = aws_instance.centos-server.id
}

output "vm_centos_server_instance_public_dns" {
  value = aws_instance.centos-server.public_dns
}

output "vm_centos_server_instance_public_ip" {
  value = aws_eip.linux-eip-centos.public_ip
}

output "vm_centos_server_instance_private_ip" {
  value = aws_instance.centos-server.private_ip
}
