FROM ubuntu:xenial
LABEL build="1.0"
LABEL author="Mujahed Altahle"
RUN apt-get update 
RUN apt-get install apache2 -y
RUN apt-get clean 
COPY docker-entrypoint /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT ["docker-entrypoint"]
STOPSIGNAL SIGWINCH
COPY apache2-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/apache2-foreground
WORKDIR /var/www/html
COPY data.json  /var/www/html
RUN chown www-data: /var/www/html/data.json
EXPOSE 80 
CMD ["apache2-foreground"]
