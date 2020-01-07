FROM ubuntu:bionic
LABEL app=proxysql
LABEL MAINTAINER=Zed<zed@zedd.dev>

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list ; \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update &&\
    apt-get install -y lsb-release ca-certificates wget gnupg mysql-client

RUN wget -O - 'https://repo.proxysql.com/ProxySQL/repo_pub_key' | apt-key add -
RUN echo deb https://repo.proxysql.com/ProxySQL/proxysql-2.0.x/$(lsb_release -sc)/ ./ \
    | tee /etc/apt/sources.list.d/proxysql.list
RUN apt-get update &&\
    apt-get install -y proxysql

RUN apt-get autoclean 

VOLUME ["/var/lib/proxysql"]
EXPOSE 6032
EXPOSE 6033

CMD ["/usr/bin/proxysql", "-c", "/etc/proxysql.cnf", "-f"]
