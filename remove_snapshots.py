#!/usr/bin/env python

import argparse
import boto3
import re
import sys

parser = argparse.ArgumentParser(description='Remove stale snapshots from an AWS account.')
parser.add_argument('--region-name', dest='region_name', action='store', required=True, help='AWS Region name, e.g. us-east-1')
parser.add_argument('--owner-id', dest='owner_id', action='store', required=True, help='AWS Account Owner ID, e.g. ABCD-EFGH-IJKL')

args = parser.parse_args()

ec2 = boto3.resource('ec2', region_name=args.region_name)

counter = 0
for snapshot in ec2.snapshots.filter(OwnerIds=[str(args.owner_id)]):
    try:
        s = [a for a in snapshot.volume.attachments]
    except:
        try:
            snapshot.delete()
            counter += 1
        except:
            # snapshot in use, skip the delete
            pass

sys.stdout.write("No. of snapshots removed: {}\n".format(counter))
sys.exit()
