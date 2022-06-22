#! /bin/bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>AWS VM on Ubuntu deployed with Terraform</h1>" | sudo tee /var/www/html/index.html
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
#Install docker
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
