#!/bin/sh

/home/ec2-user/bin/kubectl apply -f namespace.yaml

/home/ec2-user/bin/kubectl apply -f deployment.yaml

/home/ec2-user/bin/kubectl apply -f service.yaml


