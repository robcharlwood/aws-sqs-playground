#!/usr/bin/env python3
import datetime

import boto3

# create sqs client and define queue url
session = boto3.Session(profile_name="aws-terraform-personal")
sqs = session.client("sqs")
queue_url = "https://sqs.eu-west-2.amazonaws.com/692597580273/sqs-queue"

# send message to sqs queue
print("Sending message now!")
today_datetime = datetime.datetime.now()
current_time = today_datetime.time().replace(microsecond=0)
today = today_datetime.strftime("%A")

response = sqs.send_message(
    QueueUrl=queue_url,
    DelaySeconds=0,
    MessageAttributes={
        "CurrentTime": {"DataType": "String", "StringValue": f"{current_time}"},
        "Day": {"DataType": "String", "StringValue": f"{today}"},
    },
    MessageBody=(f"Information about today"),
)
print("Message sent successfully!")
