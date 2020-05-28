# Cloud_DevOps_Nanodegree_Capstone
This is the Capstone Project of Udacity Cloud DevOps Engineer Nanodegree Program

[![CircleCI](https://circleci.com/gh/MichaelOlatunji/Cloud_DevOps_Nanodegree_Capstone.svg?style=svg)](https://circleci.com/gh/MichaelOlatunji/Cloud_DevOps_Nanodegree_Capstone)

## This pipeline uses Rolling Deployment Stategy

## Run in Jenkins

* Create an AWS ec2 instance
* Install jenkins and neccessary plugins (Blueocean, AWS pipeline, Dockerpipeline, Git)
* Install aws cli and eksctl
* Install docker docker engine
* Install kubernetes
* For jenkins to run docker Run `sudo usermod -a -G docker jenkins`

## Setup the Environment

* Run `make setup` to create a virtual environment and source into it
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `make run`

### Kubernetes Steps

* Setup and Configure Docker locally
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

### Deploying App

* Upload to DockerHub Registry: `/.upload_docker.sh USERNAME PASSWORD` 
