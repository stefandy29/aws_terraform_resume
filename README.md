# aws_terraform_resume

## https://stefandi.keysersozeresume.uk

![image](diagram/test.png)
###### generated diagram using mingrammer
###### https://github.com/mingrammer/diagrams


### How to use on your local computer

### 1. Create terraform.tfvars

```
access_key = accesskey
secret_key = secretaccesskey
region     = yourregion
region_acm = yourregionacm (should be us-east-1)


cloudflare_token = cloudflaretoken
zone_id          = zoneid
account_id       = accountid

domain                    = *.yoururl.com
domain_firstname          = firstdomainname
s3_folder_location_upload = foldername_web


tags                   = tagsname
lambda_function_name   = function name
api_gateway_stage_name = urlname
```

### 2. Run using shell script

```
Terraform init
./moduleruntf.sh apply ###run the module sequencially

```

### 3. (Optional) Destroy all resource

```
Terraform init
Terraform destroy -auto-approve
```


## F.A.Q

### 1. Why using shell script instead of terraform apply?

##### The reason why you need shell script to run because you need to run the modules sequencially and separated

##### Here's the flow without using shell script
```
terraform apply -target=module.aws_dynamodb -auto-approve
terraform apply -target=module.local_file_python -auto-approve
terraform apply -target=module.aws_iam -auto-approve
terraform apply -target=module.aws_lambda -auto-approve
terraform apply -target=module.aws_api_gateway -auto-approve
terraform apply -target=module.aws_lambda_api_gateway_permission -auto-approve
terraform apply -target=module.aws_api_gateway_deploy -auto-approve
terraform apply -target=module.local_file_javascript -auto-approve
terraform apply -target=module.aws_s3_bucket -auto-approve
terraform apply -target=module.aws_acm -auto-approve
terraform apply -target=module.cloudflare_record_hidden -auto-approve
terraform apply -target=module.aws_cloudfront -auto-approve
terraform apply -target=module.cloudflare_record_real -auto-approve
terraform apply -target=module.aws_s3_policy -auto-approve
```
