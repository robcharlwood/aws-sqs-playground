#!/usr/bin/env python3
import time

import boto3

# create sqs client and define queue url
session = boto3.Session(profile_name="aws-terraform-personal")
sqs = session.client("sqs")
queue_url = "https://sqs.eu-west-2.amazonaws.com/692597580273/sqs-queue"

# receive a single message from sqs queue
def handle_next_waiting_message() -> None:
    """ process next waiting message in the sqs queue """
    response = sqs.receive_message(
        QueueUrl=queue_url,
        AttributeNames=["SentTimestamp"],
        MaxNumberOfMessages=1,
        MessageAttributeNames=["All"],
        VisibilityTimeout=10,
        WaitTimeSeconds=0,
    )
    try:
        message = response["Messages"][0]
        receipt_handle = message["ReceiptHandle"]
    except KeyError:
        print("No messages left to process")
        return

    # now that we've handle the message, delete it from the queue
    sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=receipt_handle)
    print("Received and deleted message: %s" % message["MessageId"])
    return


while True:
    print("Checking for new messages in the queue")
    handle_next_waiting_message()
    print("Complete! Will check again in 10 seconds...")
    time.sleep(10)
