provider "aws" {
  region                      = "us-east-1"
  access_key                  = "fake"
  secret_key                  = "fake"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true

endpoints {
	apigateway      = "http://localhost:4566"
	apigatewayv2    = "http://localhost:4566"
	cloudformation  = "http://localhost:4566" 
	cloudwatch      = "http://localhost:4566"
	cognitoidentity = "http://localhost:4566"    
	dynamodb        = "http://localhost:4566"
	ec2             = "http://localhost:4566"
	es              = "http://localhost:4566"
	iam             = "http://localhost:4566"
	kinesis         = "http://localhost:4566"
	lambda          = "http://localhost:4566"
	route53         = "http://localhost:4566"
	s3 = "http://s3.localhost.localstack.cloud:4566"
	secretsmanager  = "http://localhost:4566"
	ssm             = "http://localhost:4566"
	stepfunctions   = "http://localhost:4566"
	sts             = "http://localhost:4566"
  }
}




