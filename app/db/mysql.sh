#!/usr/bin/env bash

usage() {
	cat <<EOF
Usage: $(basename $0) <command>

Wrappers around core binaries:
    run                   Runs local Mysql DB in docker.
    create-db             Creates DB and Table with users.
    test                  Tests if configuration to DB is correct.
EOF
    exit 1
}

CMD="$1"

shift
case "$CMD" in
    run)
        docker run -v $PWD/data:/var/lib/mysql -v $PWD/sql:/sql -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=password mysql:5.7.24
    ;;
	stop)
        docker stop $(docker ps | grep "mysql:5.7.24" | awk '{print $1}')
    ;;
    create-db)
	    DOCKER_ID=$(docker ps | grep "mysql:5.7.24" | awk '{print $1}')
		docker exec -it $DOCKER_ID mysql -u root -ppassword -e 'source /sql/create.sql'
		docker exec -it $DOCKER_ID mysql -u root -ppassword users -e 'source /sql/tables.sql'
		docker exec -it $DOCKER_ID mysql -u root -ppassword users -e 'source /sql/test-data.sql'
    ;;
    test)
		DOCKER_ID=$(docker ps | grep "mysql:5.7.24" | awk '{print $1}')
        docker exec -it $DOCKER_ID mysql -u root -ppassword users -e 'SELECT * FROM users;'
    ;;
    *)
        usage
    ;;
esac
