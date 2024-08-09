import boto3
import json
import logging
import urllib.parse
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def sendSnsNotification(sns_arn, snsSubject, snsMessage, region_name):
    logger.info("SNS subject: " + snsSubject)
    logger.info("SNS message: " + snsMessage)
    client = boto3.client('sns', region_name=region_name)
    response = client.publish(
        TopicArn=sns_arn,
        Subject=snsSubject,
        Message=snsMessage,
    )
    logger.info(response)

def lambda_handler(event, context):
    logger.info("Event: " + json.dumps(event))
    try:
        if 'Records' in event:
            for record in event['Records']:
                if isinstance(record, dict):
                    body_content = record.get("body", "")
                    logger.info("Raw body content: " + body_content)

                    try:
                        body = json.loads(body_content)
                        logger.info("Parsed Body: " + json.dumps(body))
                    except json.JSONDecodeError as e:
                        logger.error("JSONDecodeError: Could not parse body content: {}".format(e))
                        continue

                    key = body.get('key')
                    bucket = body.get('bucket')  # Extract the bucket name from the body
                    logger.info(f"Bucket: {bucket}, Key: {key}")

                    if not key or not bucket:
                        logger.warning("Key or bucket name is missing in the message body.")
                        continue

                    file_name = urllib.parse.unquote(key)
                    missing_uri = f"s3://{bucket}/{key}"
                    print("sns arn printing")
                    sns_arn = os.environ.get("topic_arn")
                    sns_subject = f"ToTheNew | Failed Images| Event Notification"
                    sns_message = f"The file '{missing_uri}' was not found in the bucket 's3://{bucket}/'."

                    sendSnsNotification(sns_arn, sns_subject, sns_message, region_name="us-east-1")

    except Exception as e:
        logger.error("Error processing records: {}".format(e))
