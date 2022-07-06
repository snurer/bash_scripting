#!/bin/bash

echo "##installing apache##"

	sudo yum install httpd -y
	sudo systemctl enable httpd
	sudo systemctl start httpd

echo "##apache is running##"



