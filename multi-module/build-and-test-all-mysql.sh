#! /bin/bash -e


. ./set-env.sh

docker-compose -f docker-compose-mysql.yml down
docker-compose -f docker-compose-mysql.yml up -d --build mysql

./wait-for-mysql.sh

docker-compose -f docker-compose-mysql.yml up -d --build tramcdcservice

./wait-for-infrastructure.sh

docker-compose -f docker-compose-mysql.yml up -d --build

./wait-for-todo-list-services.sh

./gradlew build

docker-compose -f docker-compose-mysql.yml down