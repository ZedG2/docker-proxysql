# docker-proxysql

通过Docker运行ProxySQL

## ProxySQL

High-performance MySQL proxy with a GPL license.

[Github](https://github.com/sysown/proxysql) | [官方网站](https://www.proxysql.com/)


## Build via docker

```bash
docker build -t proxysql .
```

## Build via docker-compose

```bash
docker-compose build
```

## Run via docker

```bash
docker run -d --name "proxysql" \
    # -p "6032:6032" \ #admin-port 一般不通过容器外访问
    -p "6033:6033" \ #mysql-port
    -v "$(pwd)/etc/proxysql.cnf:/etc/proxysql.cnf:ro" \ #映射配置
    -v "<path_to_vol>:/var/lib/proxysql" \ #映射proxysql disk数据
    proxysql
```

## Run via docker-compose

```bash
docker-compose up -d
```

## Login with admin

```bash
docker-compose exec proxysql bash
# or via docker
# docker exec -t proxysql bash
mysql -u admin -padmin -h 127.0.0.1 -P6032 --prompt='Admin> '
```
