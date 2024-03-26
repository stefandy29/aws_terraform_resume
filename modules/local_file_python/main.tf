resource "local_file" "python" {
  content  = <<EOF
import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('${var.dynamodb_name}')
def lambda_handler(event, context):
    resp = table.get_item(Key={
        '${var.dynamodb_hashkey}':'1'
    })
    ${var.dynamodb_item_key} = resp['Item']['${var.dynamodb_item_key}']
    ${var.dynamodb_item_key} = ${var.dynamodb_item_key} + 1
    
    resp = table.put_item(Item={
        '${var.dynamodb_hashkey}':'1',
        '${var.dynamodb_item_key}': ${var.dynamodb_item_key}
    })
    
    return {
        'statusCode': 200,
        'body': json.dumps(f"Total Viewer : {${var.dynamodb_item_key}}"),
        'headers' : {
            'Access-Control-Allow-Origin' : '*',
            'Access-Control-Allow-Headers' : '*',
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Methods': 'POST, PUT, PATCH, GET, DELETE, OPTIONS',
            'Content-Type' : 'application/json'
        }
    }
EOF
  filename = "${path.root}/${var.lambda_function_name}.py"
}
