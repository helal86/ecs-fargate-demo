  

# ECS Fargate demo

  

The repository contains terraform code to deploy an ECS cluster running Fargate and runs a demo web application pulled from Docker hub.

  

## Requirements

Terraform >=0.12 - [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) or you can use the extremely handy [Terraform Switcher](https://warrensbox.github.io/terraform-switcher/)

  

Edit the `credentials` file in the root of the folder and enter your AWS secret and access key so that you can deploy the code - [How to generate AWS access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)

  

## Deploy using Terraform

 You can run the `deploy.sh` script which will automate the deployment using the credentials and variables set, run the script using the following command `./deploy.sh` - once complete the script will attempt to curl the load balancer for a response and display it on the terminal window. 

Manual deployment steps below: 

1. Initialise terraform by running the following command `terraform init`, terraform will download the required providers

2. Run `terraform plan` to have terraform plan the deployment which will return back with all the changes required

3. Apply the changes by running `terraform apply`, terraform will prompt you to confirm if you want to proceed, type `yes` and the deployment will begin - this will take several minutes to complete

4. Terraform will output a DNS name which can be copied into a browser and the webapp will be displayed

5. You may get a 503 error whilst the cluster is provisioning the tasks - please wait

6. To delete the whole infrastructure run `terraform destroy`, you will be prompted to confirm before everything is deleted. 
  

## What is the code doing?

  

To make it easy the credentials are read from the credentials file in the root of the folder

  

**Variables:**

  

The code uses variables to inject some settings, eg region - this can be set to eu-west-1 or us-west-2 etc and will determine the region that the infrastructure is deployed

  

Settings such as the CIDR block and app image can be changed in the variables file. The app image in use is a sample web app freely available on docker hub and is being used for the ease of this demo, there is a second app image from `mmumshad/simple-webapp` which returns back text only and runs on port `5000` - if you would like to see this demo change the `app_port` to `5000` and set the `app_image` to `mmumshad/simple-webapp:latest`

  

**Network**

  

A VPC is created with both private (containers) and public subnets (load balancer) along with an internet gateway, NAT gateway and routing tables to route traffic via the correct gateway.

  

**Load Balancer**

  

An Application Load Balancer with a target group and listener which listens to traffic on port 80 and forwards all requests to the target group.

  

**Security**

  

Security rules to allow traffic to the internet (0.0.0.0/0) to the load balancer only and rules to allow traffic from the load balancer to talk to the ECS cluster which may be running on different ports.

  

**ECS Cluster**

  

A cluster is defined and set to use fargate, the task definition is set as a template file which can also be set inline within terraform, the service is associated to the load balancer along with the security groups to lock down communication between the load balancer and ecs cluster only.

  

**Auto Scaling**

  

Auto scaling using cloudwatch metrics based on CPU usage only which triggers an increase in the number of containers should the CPU reach a threshold of 85 and scale back down when the CPU hits 40. There is a second auto scaling metric using the memory usage - the values of the threshold can be altered in the variables.tf file

  

This can be tested by using performance testing tools available online.

  
  

## Improvements

  

- Apply a SSL certificate using certificate manager and apply it to the load balancer so that traffic is served securely. Change the port from 80 -> 443 in the variables.tf file

  

- Adding logging to the container task definition and store the logs for x amount of days

  

- Create ECR repository to hold private docker images and pull the images from there to run on the ECS cluster

  

- Showcase RDS as terraform and have web app talk to the DB to pull data and display it on the website

  

- Continuous delivery - have the cluster pull the latest version of the docker image when a change is pushed

  

- Cloudwatch alarms with SNS to send out alarms

## Network Diagram 

The infrastrucure builds what is seen in the diagram below 

<img src="https://d2908q01vomqb2.cloudfront.net/1b6453892473a467d07372d45eb05abc2031647a/2018/01/26/Slide5-1024x647.png"  
alt="Network Diagram"  
style="float: left; margin-right: 10px;" />