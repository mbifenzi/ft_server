FROM	debian:buster



RUN 	apt-get update && apt-get upgrade -y
RUN    	apt-get install -y apt-utils lsb-release gnupg debconf-utils wget vim php-mysql nginx curl gnupg2 ca-certificates \
		php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring \
		php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
ENV	DEBIAN_FRONTEND=noninteractive
RUN     wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb && \ 
		echo "mysql-apt-config mysql-apt-config/select-server select mysql-5.7" | debconf-set-selections && \
    	dpkg -i mysql-apt-config_0.8.13-1_all.deb && \
    	apt-get update && \
    	rm -rf mysql-apt-config_0.8.14-1_all.deb && apt-get install -y mysql-server

COPY	srcs/localhost.crt			/etc/ssl/localhost.crt
COPY	srcs/localhost.key			/etc/ssl/localhost.key       
COPY	srcs/phpmyadmin/			/var/www/html/phpmyadmin/
COPY	srcs/wordpress/				/var/www/html/wordpress/
Copy	srcs/default/				/etc/nginx/sites-available/
COPY 	srcs/mbifenzi.sh  			/var/
COPY	srcs/mbifenzidb.sql			/var/lib/mysql/
RUN 	mkdir -p /var/lib/phpmyadmin/tmp
RUN 	chmod 777 /var/lib/phpmyadmin/tmp
RUN		chmod 777 /var/mbifenzi.sh

EXPOSE 80 443
ENTRYPOINT ["bash","/var/mbifenzi.sh"]


