setup:
	python3 -m venv ~/.devops_ml_api
	source ~/.devops_ml_api/bin/activate

install:
	pip3 install --upgrade pip && \
	pip3 install -r requirements.txt

lint:
	hadolint --ignore DL3013 Dockerfile
	pylint --disable=R,C,W1203 app.py

validate-circleci:
    # See https://circleci.com/docs/2.0/local-cli/#processing-a-config
	circleci config process .circleci/config.yml

run-circleci-local:
    # See https://circleci.com/docs/2.0/local-cli/#running-a-job
	circleci local execute

build:
	docker build -t capstone-app .

run:
	docker run -p 8000:80 capstone-app

push:
	docker tag capstone-app imykel/devops-capstone
	docker push imykel/devops-capstone

all: install lint