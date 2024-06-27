import json
import os

def get_vpcpeering_detail_create(event, context):

    if 'detail' in event:
        event_details = []
        detail={
            "SourceIPAddress": event['detail']["sourceIPAddress"],
            "EventSource": event['detail']['eventSource'],
            "EventName": event['detail']['eventName'],
            'ResourceName': event['detail']['responseElements']['vpcPeeringConnection']['vpcPeeringConnectionId']
        }
        event_details.append(detail)
    return event_details

def get_vpcpeering_detail_delete(event, context):

    if 'detail' in event:
        event_details = []
        detail={
            "SourceIPAddress": event['detail']["sourceIPAddress"],
            "EventSource": event['detail']['eventSource'],
            "EventName": event['detail']['eventName'],
            'ResourceName': event['detail']['requestParameters']['vpcPeeringConnectionId']
        }
        event_details.append(detail)
    return event_details  