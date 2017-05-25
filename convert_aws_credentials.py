#!/usr/bin/env python

import csv
import argparse

parser = argparse.ArgumentParser(description='Convert an AWS CSV credentials file into a .ini-type Boto ~/.aws/credentials file. Print results to stdout.')
parser.add_argument('--aws-csv-file', dest='aws_csv_file', action='store', required=True, help='AWS CSV credential filename')
parser.add_argument('--aws-region-name', dest='aws_region_name', action='store', required=True, help='AWS region name')

args = parser.parse_args()

with open(args.aws_csv_file, 'rb') as aws_csv_file:
    aws_csv_reader = csv.DictReader(aws_csv_file)
    for row in enumerate(aws_csv_reader):
        print '[default]'
        print 'aws_access_key_id =', row[1]['Access key ID']
        print 'aws_secret_access_key =', row[1]['Secret access key']
        print 'region =', args.aws_region_name
        if row[0] == 1:
            break
