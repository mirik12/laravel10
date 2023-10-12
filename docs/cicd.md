# GitLab CI/CD Configuration Guide

This GitLab CI/CD configuration file automates the testing, building, and deployment processes for the project. Here's an explanation of the key components of the configuration file:

## Stages

### Test
- **Stage:** Test
- **Tags:** docker
- **Image:** sonarsource/sonar-scanner-cli:4.6
- **Script:** Runs SonarCloud analysis using specified SonarCloud parameters.
- **Only:** Runs on branches and merge requests except for the `main` branch.

### Build
- **Stage:** Build
- **Tags:** docker
- **Services:** docker:dind
- **Variables:**
  - `PHP_IMAGE`: Specifies the PHP image for the application.
  - `NGINX_IMAGE`: Specifies the NGINX image for the proxy.
  - `TARGET_APP`: Specifies the target name for the PHP application Docker image.
  - `TARGET_PROXY`: Specifies the target name for the NGINX proxy Docker image.
  - `DOCKER_FILE`: Specifies the path to the Dockerfile for building the images.
- **Script:**
  - Logs in to the container registry.
  - Builds and pushes the PHP application and NGINX proxy Docker images.
- **Needs:** Depends on the successful completion of the `test` job.
- **Only:** Runs only on the `main` branch.

### Deploy
- **Stage:** Deploy
- **Tags:** docker
- **Image:** fluxcd/helm-operator:1.4.4
- **Script:** Deploys the application using Helm.
- **Needs:** Depends on the successful completion of the `test` job.
- **Only:** Manual trigger, runs only on the `main` branch.

## Workflow

1. When a branch or merge request is opened, the `test` job runs automatically, executing SonarCloud analysis.
2. If the branch or merge request is not the `main` branch, the pipeline stops after the `test` job.
3. On the `main` branch, after successful testing (`test` job), the `build` job runs to build and push Docker images for the PHP application and NGINX proxy.
4. After the `build` job, you can manually trigger the `deploy` job to deploy the application using Helm.

This CI/CD configuration automates the testing, building, and deployment processes, ensuring efficient development and delivery of project. Make sure to configure  GitLab repository's CI/CD settings to enable pipelines and specify the necessary environment variables such as `CI_REGISTRY_USER` and `CI_REGISTRY_PASSWORD` for successful execution.
