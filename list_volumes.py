#!/usr/bin/env python
import boto3
import argparse
import sys

parser = argparse.ArgumentParser(description='Looking for EC2 unattached Volumes.')
parser.add_argument('--region-name', dest='region_name', action='store', required=True, help='AWS Region name, e.g. us-east-1')

args = parser.parse_args()

ec2 = boto3.resource('ec2', region_name=args.region_name)
volumes = ec2.volumes.filter(Filters=[])
volume_list = (volume for volume in volumes)
unattached_volume_list = []
for volume in volume_list:
    volume_is_attached = False
    if volume.attachments:
        continue
    else:
        unattached_volume_list.append(volume.id)

print "unattached_volume_list: \n"
for vol in unattached_volume_list:
  sys.stdout.write(str(vol))
  print "\t"
