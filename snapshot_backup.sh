#!/bin/sh

action=$1
age=$2

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

function delete_ebs () {
  for snapshot in $(aws ec2 describe-snapshots | jq .Snapshots[].SnapshotId | sed 's/\"//g')
  
  do
    echo "snap id:" $snapshot
    snapshotdate=$(aws ec2 describe-snapshots --filter Name=snapshot-id,Values=$snapshot | jq .Snapshots[].StartTime | cut -d T -f1 | sed 's/\"//g')
    echo "snapshotdate:" $snapshotdate
    exit2
    startdate=$(date +%s)
    echo "start:" $startdate
    enddate=$(date -d $snapshotdate +%s)
    echo "date:" $enddate
    interval=$[ (startdate - enddate) / (60*60*24) ]
    echo "interval:" $interval
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
    delete_ebs
    ;;
esac
