# ApplicationDeploymentUsingECS_CloudFormation
PHP application deployment in ECS Container with the help of cloudFormation
Insturactions are listed bewlow to run this script.

Components:

* VPC
* Subents
* SecurityGroups 
* Application Load Balancer 
* AutoScalling Group
* IAM Roles
* EC2 containerInstance 
* EC2 Based ECS Cluster
* ECS Service


Flow of Application:

1- First of all you need to create a Role which would let your cluster to add containerInstance in it. In this file that Role is named as ecsInstanceRole. 

2- Create a EC2 based cluster. Define number of instances and here we would be using special optimized ec2 instances. EC2 container instacne would be created using LaunchConfiguration and AutoScalling group.

3- Here we would define Task Defintion, it's a blue print we define container attribute in it. In this script we created two task defintion one for php-apache and another for mysql, basically we add container defintion inside the task definition. You are supposed to create role for task execution here as well, in this script that role named as ecsTaskexecuation.

4- After that we will create service for php-apache task defintion. In this script service is created with 2 as DesiredCount.

5- We would attach a LoadBalancer to that service. 

6- Define a role for handling LoadBalancer with service. In this script A Role was created with name ecsServiceRole and an application LoadBalancer had been created as well.

7- we need to create a target group for an Application LoadBalancer. We also need to create a LoadBalancer listener. 

8- In the end we will create an application LoadBalancer ListenerRule that would send traffic on our service.

