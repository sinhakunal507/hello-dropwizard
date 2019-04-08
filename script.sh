#!/bin/bash

url='https://github.com/haroonzone/hello-dropwizard.git'
proj_path='/dropwizard'

yum install git httpd -y
wait
if [[ $? -gt 0 ]]
	then
	echo "Unable to install git http"
	exit
else
	echo "GIT http Installed successfully"
fi

yum install maven -y
wait
if [[ $? -gt 0 ]]
	then
	echo "Unable to install maven"
	exit
else
	echo "MAVEN Installed successfully"
fi

mkdir $proj_path
cd $proj_path

git clone $url
wait
if [[ $? -gt 0 ]]
	then
	echo "Unable to Clone Dropwizard Project"
	exit
else
	echo "Dropwizard Project Cloned successfully"
fi

cd "$proj_path"/hello-dropwizard

mvn package
wait
if [[ $? -gt 0 ]]
	then
	echo "mvn package command failed"
	exit
else
	echo "mvn package command completed successfully"
	
fi
nohup java -jar target/hello-dropwizard-1.0-SNAPSHOT.jar server example.yaml &
echo 'Redirect permanent /hello http://localhost:8080/hello-world' > /etc/httpd/conf.d/hello-world.conf
service httpd start
