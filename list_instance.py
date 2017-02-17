import boto.ec2

conn=boto.ec2.connect_to_region("eu-west-1")  # the AWS instance Region
reservations = conn.get_all_instances()
for res in reservations:
    for inst in res.instances:
        if 'Name' in inst.tags:
            print "id: (%s) \t name: \t[%s]" % (inst.id, inst.tags['Name'])
        else:
            print "id: (%s)" % (inst.id)
