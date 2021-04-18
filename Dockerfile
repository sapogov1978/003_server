# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: brattles <brattles@student.21-school.ru    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/08 00:46:45 by brattles          #+#    #+#              #
#    Updated: 2021/02/16 01:43:37 by brattles         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y --no-install-suggests install wget && \
    apt-get -y install openssl

RUN apt-get -y --no-install-suggests install nginx
COPY srcs/ft_server_autoindex_on.conf /etc/nginx/conf.d/ft_server.conf
RUN touch /var/www/index.php && echo "<?php phpinfo(); ?>" >> /var/www/index.php

RUN apt-get -y --no-install-suggests install mariadb-server

RUN apt-get -y install php-cli php-fpm php-cgi php-mysql php-mbstring

EXPOSE 80 443

COPY srcs/start.sh ./
COPY srcs/*autoindex*.* ./
RUN chmod 777 autoindex*.sh
CMD bash start.sh