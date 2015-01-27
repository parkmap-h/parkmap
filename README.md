Dockerを利用して開発する場合

```
docker run -d --name parkmap-db mdillon/postgis:9.4
docker build -t parkmap .
docker run --rm -it --link parkmap-db:db parkmap rake db:setup
docker run --rm -it -v "$(pwd)":/usr/src/app --link parkmap-db:db  -p 3000:3000  parkmap
```

二度目以降

```
docker run -d --name parkmap-db mdillon/postgis:9.4
docker run --rm -it -v "$(pwd)":/usr/src/app --link parkmap-db:db  -p 3000:3000  parkmap
```

Gemfileを変更したら

```
docker build -t parkmap .
docker run --rm -it -v "$(pwd)":/usr/src/app --link parkmap-db:db parkmap bundle install
```
