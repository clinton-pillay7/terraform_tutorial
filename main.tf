

#provider "archive" {}
#data "archive_file" "zip"{
#        type = "zip"
#        source_file = "script.py"
#        output_path = "script.zip"
#}


#s3 config
resource "aws_s3_bucket" "bucket"{
	bucket = var.bucket_name
        tags = {
                Name = "My-Bucket"
                Environment = "Test"
                }
}


resource "aws_s3_bucket_notification" "aws-lambda-trigger"{
        bucket = aws_s3_bucket.bucket.id
        lambda_function{
                lambda_function_arn = aws_lambda_function.lambdascript.arn
                events = ["s3:ObjectCreated:*"]
        }
}

#lambda config

#lambda role config
resource "aws_iam_role" "iam_for_lambda"{
        name = "iam_for_lambda"
        assume_role_policy = "${file("lambdapolicy.json")}"
}

#lambda function creation
resource "aws_lambda_function" "lambdascript" {
        function_name = "script"
        filename = "script.zip"
        role = aws_iam_role.iam_for_lambda.arn
        handler = "script.script"
        runtime = "python3.9"

}

resource "aws_lambda_permission" "test"{
	statement_id = "AllowS3Invoke"
	action = "lambda:InvokeFunction"
	principal = "lambda.amazonaws.com"
	function_name = aws_lambda_function.lambdascript.function_name

}

resource "aws_iam_role" "iam_for_dynamo"{
        name = "iam_for_dynamo"
        assume_role_policy = "${file("dynamo.json")}"
}

resource "aws_dynamodb_table" "dynamodb_table" {
        name = "terratable"
        billing_mode = "PROVISIONED"
        read_capacity = 20
        write_capacity = 20
        hash_key = "id"
        range_key = "filename"
	attribute {
                name = "id"
                type = "S"       
        }
        attribute {
                name = "filename"
                type = "S"

        }

}


