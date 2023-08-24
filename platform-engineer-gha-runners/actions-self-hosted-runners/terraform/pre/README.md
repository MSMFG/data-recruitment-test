# about
this terraform is used to provision a project for a candidate

state should be kept locally


terraform.tfvars
```hcl
folder_id = 123
billing_account = "xxx"
candidate_initials = "bm"
candidate_email = "xxx@gmail.com"
gh_token   = "github_pat_123...."
```

terraform init
terraform apply -target=module.project_setup
terraform apply -target=module.permission_grant
