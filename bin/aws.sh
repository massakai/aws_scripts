#!/bin/bash
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#
# Amazon Web Services Command Samples
#
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

#
# Amazon Elastic Compute Cloud (EC2)
# 
# [TODO] Read later
#     Classless Inter-Domain Routing (CIDR)
#     http://ja.wikipedia.org/wiki/Classless_Inter-Domain_Routing
#

function import_keypair() {
    ec2-import-keypair --region ${REGION} --public-key-file ${PUBLIC_KEY} ${KEYPAIR_NAME}
}

function generate_keypair() {
    ec2-add-keypair ${KEYPAIR_NAME}
}

function generate_security_group() {
    ec2-add-group ${SECURITY_GROUP} -d ${DESC}
    ec2-authorize ${SECURITY_GROUP} -P tcp -p ${PORT} -s ${CIDR}

function run_instance() {
    ec2-run-instance ${AMI} \
                     --instance-count 1 \
                     --instance-type m1.small \
                     --key ${KEYPAIR_NAME} \
                     --group ${SECURITY_GROUP}
}

function stop_instance() {
    ec2-stop-instances ${INSTANCE}
    ec2-detach-volume ${VOLUME}
}

function start_instance() {
    ec2-start-instances ${INSTANCE}
    ec2-attach-volume ${VOLUME} -i ${INSTANCE} -d ${DEV}
    ec2-associate-address ${EIP} -i ${INSTANCE}
}

function create_image() {
    ec2-create-image ${INSTANCE} -n ${APP_SERVER} -d ${DESC}
}

#
# AWS Elastic Block Store (EBS)
#

#sudo apt-get install xfsprogs
#sudo mkdir -p /var/www
#sudo mkfs.xfs /dev/sdf
#mount -t xfs 0o defaults /dev/sdf /var/www

#
# AWS Identity and Access Management (IAM)
# http://aws.amazon.com/jp/iam/
#
# [TODO] Read later
#   AWS Policy Generator
#   http://awspolicygen.s3.amazonaws.com/policygen.html
#

function create_user() {
    # output access keys
    iam-usercreate -u ${USER} -k
}

function add_policy_to_user() {
    iam-useraddpolicy -u ${USER} -p S3_ACCESS -e Allow -a "s3:*" -r "*"
}
