import os
import json
import boto3
import urllib
import uuid

endpointurl = f'http://{os.getenv("LOCALSTACK_HOSTNAME")}:{os.getenv("EDGE_PORT")}'

def script(event,context):
                clientd = boto3.client('dynamodb',region_name='us-east-1',endpoint_url=endpointurl)
                s3_client = boto3.client("s3")
                bucket_name = event['Records'][0]['s3']['bucket']['name']
                key = event['Records'][0]['s3']['object']['key']
                key = urllib.parse.unquote_plus(key, encoding ='utf-8')
                message = "hey this file got uploaded" + key + 'to this bucket' + bucket_name
                id_db = uuid.uuid4()
                idval = str(id_db)
                clientd.put_item(TableName='terratable',Item={'id':{'S':idval},'filename':{'S':key}})
                return "success"

