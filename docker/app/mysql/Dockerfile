FROM mysql:5.7

ENV TZ UTC
RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime && echo UTC > /etc/timezone

COPY my.cnf /etc/mysql/conf.d/my.cnf

# Ensure files owned by mysql user
RUN chown -R mysql:mysql /var/lib/mysql

CMD ["mysqld"]

EXPOSE 3306
