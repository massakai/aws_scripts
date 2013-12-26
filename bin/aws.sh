#!/bin/bash

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

#
# AWS EBS
#

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
