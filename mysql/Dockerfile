FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=mysql
ENV MYSQL_DATABASE=movie_management
ENV MYSQL_USER=hamza
ENV MYSQL_PASSWORD=110022

COPY init.sql /docker-entrypoint-initdb.d/
