# System requirements:
1. Software installed:
   * Docker
   * Terraform
2. AWS account with administrator privileges.

# Description:
1. The Golang application provided was packaged to the Docker container and pushed to the docker hub:
```sh
cd <<project_folder>>
docker build -t karlson/sigma-server:latest . && docker push karlson/sigma-server:latest
```
2. Access key ID and secret access key should be placed into the file ~/.aws/credentials.
3. The variables can be changed in the file ``<<project_folder>>/tf/vars.tf``

    If the region should be changed the AMI ID can be found by the [link](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)

4. After ``terraform apply`` command execution the next changes will be performed:

    * IAM roles described in ``<<project_folder>>/tf/iam.tf`` will be created.
    * Security groups defined in ``<<project_folder>>/tf/security_groups.tf`` will be created.
    * ECS cluster and the ECS tasks with our docker image will be created.``<<project_folder>>/tf/ecs.tf`` and ``<<project_folder>>/tf/task-definition.json.tmpl``
    * The application load balancer will be created and configured. ``<<project_folder>>/tf/alb.tf``
    * The autoscaling group will be created with the policies to scale up and scale down depends on the CPU usage. ``<<project_folder>>/tf/autoscaling_group.tf``
        The minimum number of instances is 2 and they will be placed in different availability zones (a, b or c for the Ireland eu-west-1 region). The maximum number of instances was set to 4.
    * The CloudWatch metrics will be created to trigger the scale up and scale down processes. ``<<project_folder>>/tf/cloudwatch.tf``
