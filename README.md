These are the assignments that I have done during my training.

# Infrastructure as code:
    
   * CloudForamtion:

        1-  A simple PHP and Mysql application deployment on Aws using Cloudformation stack:

            * A VPC to handle network.
            * An AutoScalling Group in public subnets.
            * A LoadBalancer sending traffic to the auto scalling group.
            * A Database Server in private subnet.

        2-  A simple PHP and Mysql application deployment on Aws using nested Cloudformation stack approach:

            * A VPC to handle network.
            * An AutoScalling Group in public subnets.
            * A LoadBalancer sending traffic to the auto scalling group.
            * A Database Server in private subnet.

            These All resources are nested in file named as parentStack.yaml.


        3- PHP application deployment in ECS Container with the help of cloudFormation
        Insturactions are listed bewlow to run this script:

            Components:

            * EC2 Based ECS Cluster
            * VPC
            * Subents
            * SecurityGroups 
            * AutoScalling Group for ec2 cluster
            * IAM Roles
            * ECS Task definition with 2 tasks
            * ECS Service for tasks
            * Application Load Balancer for service 


    * Terraform:
            
        1- AWS RDS Aurora Cluster deployment using terraform:

            * env with test and dev stages.
            * A module for RDS cluster.
            * Local state managament.


        2- Running php and mysql application on ec2 cluster using terraform:

            Modules:

            * virtual_private_gateway
            * ecs_cluster
            * iam_roles
            * task_definition
            * services
            * application_loadbalancer 

            * backend.tf
               * To store state remotely on AWS S3. 
               * DyanmoDB locking. 

            * starter.sh to perform terraform plan and terraform plan.


        3- Running simple nginx image on fargate cluster using terraform. All configurations are similiar with few exceptions. Such as cluster required capabilties of fargate. Service launch type fargate and running with replica type.


# Deployments:

    * Docker:

        1- Docker-compose to package and deploy a python and redis app with nginx:

            * Dockerfile for each.
            * requirements.txt file to install requriements.


    * Kubernetes:

        1- Php and mysql application deployment with kubernetes:

            * Deployment for php and mysql pods.
            * Service creation for the php and mysql


# CICD:

    * Jenkins:
       
        1- Scripted pipeline for nginx application on ec2 cluster:
           
           * Integrate with Github.
           * Cloudfromation script. 
           * Bulidng Dockerfile and push it on ecr.  
           * Jenkinsfile -> creating ac ecs cluster.
           * Jenkinsfilev2 -> Buling nginx image with build arguments and pushing it over ecr. In the next stage creating service for the cluster that got created by first pipeline.


        2- Declarative pipeline to provision simple Application load balancer with terraform:

           * Seed Job named as terraform.grooy to create declarative pipeline using job DSL plugin.

           * pipeline with 3 stages, terraform init, terraform plan and terraform apply respectively.
         

    * AWS CodePipeline:

        1- A simple student data gathering app using nodeJS and ExpressJS with template engine ejs. Created CI/CD for this application using AWS CodeDeploy and AWS CodePipline.  

           * appspec.yaml file with hooks     
               * before_install.sh to install the nodeJS and forever libaray on the node.
               * after_install.sh to to make directory for application and install its packages.
               * application_start.sh to start the apllication on the server.



## Serverless framework:
    
    * NodeJS Template is used.
    * simple NodeJS CRUD operation with DynmaDB.
    * Write and get file from s3 operation.