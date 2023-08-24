# Simple Self Hosted runners on GKE

## Steps to deploy this example

- Step 1: follow directions in terraform/pre/README.md

- Step 2: Create the infrastructure.

```sh
terraform init
terraform plan
terraform apply
```

- Step 3: Build the example runner image using Google Cloud Build. Alternatively, you can also use a prebuilt image or build using a local docker daemon.

```sh
export PROJECT_ID=msmg-platengchal-benm
gcloud --project=$PROJECT_ID builds submit --config=cloudbuild.yaml
```

- Step 4: Replace image in [sample k8s deployment manifest](./sample-manifests/deployment.yaml).

```sh
kustomize edit set image gcr.io/PROJECT_ID/runner:latest=gcr.io/$PROJECT_ID/runner:latest
```

- Step 5: Generate kubeconfig and apply the manifests for Deployment and HorizontalPodAutoscaler.

```sh
gcloud container clusters get-credentials your-cluster-name --zone=your-cluster-zone
kustomize build . | kubectl apply -f -
```

- Step 6: Your runners should become active at https://github.com/owner/your-repo-name/settings/actions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gh\_token | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| project\_id | The project id to deploy Github Runner MIG | `string` | n/a | yes |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| repo\_url | Repo URL for the Github Action | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate | The cluster ca certificate (base64 encoded) |
| client\_token | The bearer token for auth |
| cluster\_name | Cluster name |
| kubernetes\_endpoint | The cluster endpoint |
| location | Cluster location |
| network\_name | Name of VPC |
| service\_account | The default service account used for running nodes. |
| subnet\_name | Name of VPC |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
