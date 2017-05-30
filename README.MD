# DEVOPSSTUFF

## Scripts for AWS and Devops Automation.

### list_volumes.py:
  ```This script will print unused volumes for a region owned by the user, based on user aws config.```
    ``USAGE: list_volumes.py --region region_name``

### list_instance.py:
  ```This script will print instances region, based on user aws config.```
  ``USAGE: list_instance.py --region region_name``

### snapshot_backup.sh:
  ```This Script will Create and  delete Elastic Block Storage(EBS) Volume snapshot.```
  ```User can define the age of snapshot to delete.```
    `` USAGE: 
      ``Backup: snapshot_backup.sh backup
        Delete: snapshot_backup.sh delete 100(age)``

### handle-unreachable-host.yml:
  ```Ansible playbook to handle failing/unreachable host.```

### getip_regex.yml:
  ```Ansible playbook with regex to get/delete the  lines starting with IP-Address from a file.```

### add-inmemory-host.yml:
  ```Ansible-playbook to login dynamically created instance, which is not part of hosts(inventory) file.```

### convert_aws_credentials.py:
  ```convert aws cred in .config file.```

## ansible directory:
  ```All ansible playbooks and roles```

##Contact:
  ```sanjaym756@gmail.com```
