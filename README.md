*Author: [Myroslav Kyselytsia](mirik12mirik@gmail.com)*

# Additional Resources
For detailed documentation and setup instructions, please refer to the following files in the docs directory:

- [Terraform Setup ](docs/tf.md)
- [Helm Chart Usage ](docs/helm.md)
- [CI/CD Setup ](docs/cicd.md)

# Laravel 10 Boilerplate

The goal of this project is to serve as a boilerplate for Laravel 10
utilizing light-weight alpine linux images for nginx and php 8.2 (fpm).

Stack:

- app @ php:8.2-fpm-alpine
- nginx @ nginx:alpine
- mysql @ mysql
- redis @ redis:alpine
- worker-local @ php:8.2-alpine3.16

## TODO

- add a basic, highly optional seeder for user
- hook up worker-local so you have a queue to play with
- create an example job/worker you might co-locate on same hardware
- maybe add some ci/cd and even k8s stuff as an example to scale out workers/nginx/edges

## Notes

- docker/app docker/nginx will rely on supervisor to maintain their processes, yawn
- Please see .env "#PORT FORWARDS" before starting in docker-compose
-

## Installation

The default docker-compose config here exposes ports if you want them.  See .env's "PORT FORWARDS"

```shell
cp ./env.example ./.env
docker-compose up --build -d app nginx mysql

#docker-compose exec app php artisan migrate
```

You can now access http://localhost:8022 (or whatever your FORWARD_NGINX_PORT is).

Please keep ./composer.lock in docker/app container context, for example:

```shell
docker-compose exec -u root app /bin/sh
# then...
# COMPOSER_MEMORY_LIMIT=-1 app composer install
# COMPOSER_MEMORY_LIMIT=-1 app composer require awesome/package_etc
# ymmv w/ COMPOSER_MEMORY_LIMIT maybe try without
```

-------------


Creating an AWS EKS cluster using Terraform involves several steps. You need to set up the AWS CLI, install Terraform, and then use Terraform to create the EKS cluster. Here are the detailed steps:

Step 1: Set up the AWS CLI
Firstly, make sure that the AWS Command Line Interface (CLI) is installed on your machine. You can do this by running the following command:
aws --version

If it's not installed, you can install it by following the official AWS guide registry.terraform.io.

After installing the AWS CLI, configure it with your AWS credentials:
aws configure

Step 2: Install Terraform
Next, install Terraform on your machine. You can verify if it's already installed by running:
terraform --version

If it's not installed, you can install it by following the official Terraform guide developer.hashicorp.com.

Step 3: Create a Terraform Configuration File
Create a new directory for your Terraform configuration files, then create a file named main.tf in this directory. The configuration file will contain the AWS provider configuration and the EKS cluster resource.

After you have created the main.tf file, initialize your Terraform configuration:
terraform init

Finally, create your EKS cluster:
terraform apply

Terraform will show you what resources it plans to create. Type yes to proceed.

Once the process completes, your AWS EKS cluster should be up and running. You can verify this by going to the EKS section in the AWS Management Console.

When you're done with the cluster, remember to destroy it to avoid unnecessary costs:
terraform destroy

