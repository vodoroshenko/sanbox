#!/bin/bash
#ip ro add 0.0.0.0/0 via ad_int1
yum update -y
yum install -y httpd
echo "<html><body bgcolor=white><center><h1><p><font color=red>Hello World</h1></center></body></html>" > /var/www/html/index.htm
uname -a >> /var/www/html/index.htm
systemctl start httpd
systemctl enable httpd
