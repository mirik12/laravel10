# Creating a Helm Chart

## Directory Structure

```
.
└──**k8s
    ├──**Chart.yaml
    ├──**Dockerfile
    ├── apache-deployment.yaml
    ├── docker-entrypoint.sh
    ├── nginx-deployment.yaml
    └── templates
        ├── NOTES.txt
        ├── _helpers.tpl
        ├── deployment.yaml
        ├── hpa.yaml
        ├── ingress.yaml
        ├── service.yaml
        ├── serviceaccount.yaml
        └── tests
            └── test-connection.yaml
```

## File Descriptions

- **k8s/Chart.yaml**: This file contains basic information about the Helm Chart such as name, version, and description.

- **k8s/Dockerfile**: File for building the Docker image that will be used in Kubernetes.

- **k8s/apache-deployment.yaml**: Configuration file for Apache server in Kubernetes Deployment format.

- **k8s/nginx-deployment.yaml**: Configuration file for Nginx server in Kubernetes Deployment format.

- **k8s/docker-entrypoint.sh**: Script that will be used as the entry point for the Docker container.

- **k8s/templates**: Directory where Kubernetes manifest templates are stored.

  - **k8s/templates/deployment.yaml**: General template for Kubernetes Deployment configuration.

  - **k8s/templates/hpa.yaml**: Template for Kubernetes Horizontal Pod Autoscaler configuration.

  - **k8s/templates/ingress.yaml**: Template for Kubernetes Ingress configuration.

  - **k8s/templates/service.yaml**: Template for Kubernetes Service configuration.

  - **k8s/templates/serviceaccount.yaml**: Template for Kubernetes Service Account configuration.

  - **k8s/templates/tests/test-connection.yaml**: Template for a test manifest that can be used to check connectivity with the service.

- **k8s/values.yaml**: File with configuration values that can be overridden by the user during Helm Chart installation.

- **README.md**: File where you can provide instructions and detailed information about using this Helm Chart.

## Usage Instructions

1. **Fill out values.yaml**: Populate the configuration values in the `k8s/values.yaml` file according to your requirements.

2. **Initialize Helm Chart**: Run the command `helm create mychart` to initialize a new Helm Chart or use the existing files and directories in the `k8s` folder.

3. **Configure Manifests**: Customize the `k8s/templates/deployment.yaml`, `k8s/templates/service.yaml`, `k8s/templates/ingress.yaml`, and other files as per your application's needs.

4. **Build and Install Helm Chart**: Use the commands `helm lint mychart` to check the Helm Chart for errors and `helm install myrelease . -f k8s/values.yaml` to install the Helm Chart using the values from `k8s/values.yaml`.

*Author: [Myroslav Kyselytsia](mirik12mirik@gmail.com)*

