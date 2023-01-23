#!/bin/sh
ls

NAME="Ramesh Reddi"
echo $NAME

cat main.tf

terraform fmt -check -diff

terraform fmt

terraform init

terraform validate

terraform plan

terraform apply