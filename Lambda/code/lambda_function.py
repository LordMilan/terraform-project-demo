import boto3
import json
from decimal import Decimal

def create_table(dynamodb, table_name):
    try:
        table = dynamodb.create_table(
            TableName=table_name,
            KeySchema=[
                {
                    'AttributeName': 'id',
                    'KeyType': 'HASH'  # Partition key
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': 'id',
                    'AttributeType': 'S'
                }
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits': 5,
                'WriteCapacityUnits': 5
            }
        )
        return f"Table {table_name} created successfully."
    except dynamodb.meta.client.exceptions.ResourceInUseException:
        return f"Table {table_name} already exists."
    except Exception as e:
        return str(e)

def insert_record(dynamodb, table_name, record):
    try:
        table = dynamodb.Table(table_name)
        table.put_item(Item=record)
        return f"Record inserted into {table_name} successfully."
    except Exception as e:
        return str(e)

def get_records(dynamodb, table_name):
    try:
        table = dynamodb.Table(table_name)
        response = table.scan()
        return response.get('Items', [])
    except Exception as e:
        return str(e)

def decimal_default(obj):
    if isinstance(obj, Decimal):
        return float(obj)
    raise TypeError

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    
    service_type = event.get('service_type')
    table_name = event.get('table_name')
    record = event.get('record')
    
    if service_type == 'create_table' and table_name:
        result = create_table(dynamodb, table_name)
    elif service_type == 'insert_record' and table_name and record:
        result = insert_record(dynamodb, table_name, record)
    elif service_type == 'get_records' and table_name:
        result = get_records(dynamodb, table_name)
    else:
        result = "Invalid service_type, table_name, or record."

    return {
        'statusCode': 200,
        'body': json.dumps(result, default=decimal_default)
    }
