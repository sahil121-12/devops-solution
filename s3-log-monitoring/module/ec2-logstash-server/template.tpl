#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install java-1.8.0-openjdk-devel -y
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.13.3.rpm
sudo rpm --install logstash-7.13.3.rpm



sudo systemctl enable logstash
sudo systemctl start logstash

