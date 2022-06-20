Tasks (mandatory):
item3:
3.1 Go to EC2 Dashboard

3.2 Press 'Launch the instance'

3.3 Choose: OS type, instance type; press 'Create new key pair'; set up 'Network settings' and configure 'Configure storage' 

3.4 Press 'Launch instance' at 'Summary' tab

3.5 Waiting for VM started and it status 'Running'

3.6 Edit 'Inbound Rules' for allow HTTP (HTTPS) access and ping:

3.6.1 Press on VM - Go to 'Security details' - Press on name of 'Security groups' - Press 'Edit Inbound rules' - Press 'Add rule'

3.6.2 For allow HTTP choose 'Type' - HTTP - choose 'Source' and input 'Cidr blocks'

3.6.3 For allow ping need to add two rules: choose 'Type' - Custom ICMP-IPv4, choose 'Protocol' - Echo Reply and Echo Request, choose 'Source' and input 'Cidr blocks'

3.7 Repeat item 3.2-3.6 to create second instance


item4:

4.4 SSH om VMs with command: ssh -i [path to pem certificate] [user_name]@[IP address] - for SSH we use external IP


item 5:

5.1 For configure SSH connectivity between instances using SSH key we need copy pem keys to VMs


item 6:

6.1 Install nginx - sudo apt update, sudo apt install nginx

6.2 Create a web page by create index.html file and put there code

6.3 Check configuration by command 'curl 'https://localhost:80/''

6.4 Check logs files for errors

6.5 Open brower and write address of your VM.

6.6 To sure on the instance without nginx/apache you also maysee the content of your webpage from the instance with nginx/apache we can use command  'curl 'https://ip address of VM with nginx:80/'' 




EXTRA (optional):

item 1:

1.1 Go to VPC dashboard

1.2 Press on 'Create VPC' 

1.3 For custom settings choose 'VPC only', for automate setting choose 'VPC and more'

1.4 Input necessary address to 'IPv4 CIDR block'

1.5 Press 'Create VPC'

1.6 Press 'Launch EC2 instances' and do item 3 from Tasks (mandatory)

1.7 Repeat item 1.1-1.6 to crete second VPC and VM in this VPC

1.8 Create peering connection

1.9 Add routes with peering connection to subnets

1.10 Check connectivity via external and internal IP - PASS


item 2:

2.1 Write BASH script and copy it to VM

2.2 Make it executetable and run

2.3 Check configuration by command 'curl 'https://localhost:80/''

2.4 Check logs files for errors

2.5 Open brower and write address of your VM


item3:

3.1 To run step.6 without “manual” EC2 SSH connection we need add the BASH script to Advanced details - User data

3.4 Launch instance



EXTRA (optional optional):

item 1:

1.1 Make a screenshot only of your web page сontent from your browser


item 2:

2.1 Go to Amazon S3

2.2 Press 'Create Bucket'

2.3 Write 'Bucket name'

2.4 Press 'Create Bucket'

2.5 Upload screenshot there


item 3:

3.1 To make screenshot visible on the internet we need go to Permissions tab

3.2 Uncheck the “Block all public access” and press 'Save'

3.3 Go to 'Bucket policy' and put there code:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::name of bucket/*"
        }
    ]
}
press save

3.3 To take link we need press on bucket name then on uploaded file name then 'Properties'

3.4 In 'Object overview' tab we can find necessary link 'Object URL', copy it and paste in browser 

