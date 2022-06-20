#!/bin/bash
#Beginning installation of nginx web server
sudo apt update
sudo apt install nginx
sudo systemctl enable nginx
#Create web page
sudo mkdir -p /etc/nginx/www/data
#Create body of webpage
sudo cat > /etc/nginx/www/data/index.html <<'EOF'
<html>
  <head>
    <title>Task2 Sanbox</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <center>
    <h1>
      Hello World!
    </h1>
    </center>
  </body>
</html>  
EOF
lsb_release -d >>/etc/nginx/www/data/index.html
df -h >> /etc/nginx/www/data/index.html
free >> /etc/nginx/www/data/index.html
ps -a >> /etc/nginx/www/data/index.html

sudo chmod 0755  /etc/nginx/www
sudo chmod 644 /etc/nginx/www/data/index.html
echo "index webpage created "  >> /tmp/debug.log
#set conf in nginx
cat > /etc/nginx/nginx.conf <<'EOF'
worker_processes 1;

events {
    worker_connections 1024;
}

http {

    server {
        listen 80 reuseport;
        
        location / {
            root /etc/nginx/www/data/;
        }
    }
}
EOF
sudo service nginx restart
