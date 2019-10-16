# Java in Container

Repository contains `pptx` presentation and `users-app` Java application used in my talk: "Java in Container - Best Practicies for containerized Java Apps" which I gave at [JDD](https://jdd.org.pl/)

## Presentation

[JavaInContainer.pptx](presentations/JavaInContainer.pptx)

## Java Application

Application used as Demo in my presentation is located [HERE](https://github.com/mateuszdyminski/java-in-container/tree/master/users-app). It's simple REST API application, features:

* Spring Boot App
* Uses MySQL as storage
* REST API
* Purpose - CRUD operations over Users dataset

### Prerequisits

* Java 8+
* Docker
* Maven

### Database deploy

```bash
cd users-app/db
./mysql.sh start # starts docker image with MySQL locally
./mysql.sh create-db  # creates DB in docker image with MySQL
./mysql.sh test  # tests whether the DB is working properly, the output should be:
+----+-----------+------------+------------+
| id | firstName | secondName | birthDate  |
+----+-----------+------------+------------+
|  1 | Tom       | Tailor     | 1962-07-04 |
|  2 | Tommy     | Hilfiger   | 1976-01-28 |
|  3 | Coco      | Chanel     | 1917-02-14 |
+----+-----------+------------+------------+
```

### Application deploy

Application uses `mysql` as address of DB, so to configure your local development please add `127.0.0.1       mysql` entry in your `/etc/hosts` file to make it working locally.

Please note that all commands are run from `users-app` directory.

Build java app:

```bash
./mvnw clean install
```

Run Java app:

```bash
java -jar target/users-app-1.0.jar
```

To test whether application works, open: [http://localhost:8080/api/users](http://localhost:8080/api/users) - 3 users should be shown to you.

To build docker image with appropriate Dockerfile:

```bash
docker build -f v1.Dockerfile --tag="mateuszdyminski/users-app:v1" .
```

where `v1` if prefix for Dockerfile, there are 6 different Dockerfiles provided.

To run application in Docker:

```bash
docker run -d --link db:mysql -p 8080:8080 "mateuszdyminski/users-app:v1"
```

## Credits

This presentation would not have been possible without:

* [Docker Containers & Java: What I Wish I Had Been Told](https://www.youtube.com/watch?v=d7ajT14ENKk)
* [Docker signals](https://hynek.me/articles/docker-signals/)
* [Spring Boot Docker](https://spring.io/guides/gs/spring-boot-Docker/)

Images comes from: [https://unsplash.com/](https://unsplash.com/)