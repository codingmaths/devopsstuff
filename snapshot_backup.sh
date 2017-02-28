#!/bin/sh

# This script is for snapshot backup and deletion. we can use it for snapshot bakup policy, based on our organisation requirement. 
# Reuirement: 1. privileged AWS access to perform the task. 2. yum install jq(for centos).
### USAGE:
## Backup: snapshot_backup.sh backup
## Delete: snapshot_backup.sh delete 100(age)
# --


action=$1   # backup/delete
age=$2      # no of day old snapshot to delete

if [ -z $action ]; 
then
  echo "action not defined, add backup/delete action"
  exit 1
fi


if [ $action = 'delete' ] && [ -z $age ];
then
  echo "Define snapshot age to delete in number of days"
  exit 1
fi

function backup_ebs () {

  for volume in $(aws ec2 describe-volumes | jq .Volumes[].VolumeId | sed 's/\"//g')
  do
    echo $volume
    echo creating snapshot for $volume $(aws ec2 create-snapshot --volume-id $volume --description 'volume-backup-script')
  done
}

function delete_snapshot () {
  for snapshot in $(aws ec2 describe-snapshots | jq .Snapshots[].SnapshotId | sed 's/\"//g')
  
  do
    snapshotdate=$(aws ec2 describe-snapshots --filter Name=snapshot-id,Values=$snapshot | jq .Snapshots[].StartTime | cut -d T -f1 | sed 's/\"//g')

    startdate=$(date +%s)    #todays date 
    enddate=$(date -d $snapshotdate +%s)  #snapshot creation date
    interval=$[ (startdate - enddate) / (60*60*24) ]

    if (( $interval >= $age ));
    then
      aws ec2 delete-snapshot --snapshot-id $snapshot
    fi

  done
}

case $action in
  backup)
    backup_ebs
    ;;
  delete)
    delete_snapshot
    ;;
esac
