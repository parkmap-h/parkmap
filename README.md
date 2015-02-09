[![Circle CI](https://circleci.com/gh/parkmap-h/parkmap.svg?style=svg)](https://circleci.com/gh/parkmap-h/parkmap)
[![Dependency Status](https://gemnasium.com/parkmap-h/parkmap.svg)](https://gemnasium.com/parkmap-h/parkmap)
[![Code Climate](https://codeclimate.com/github/parkmap-h/parkmap/badges/gpa.svg)](https://codeclimate.com/github/parkmap-h/parkmap)
[![Coverage Status](https://coveralls.io/repos/parkmap-h/parkmap/badge.svg)](https://coveralls.io/r/parkmap-h/parkmap)

パークマップ
===
# 目的
広島の近隣の駐車場を探せるようにする

# 前提
| ソフトウェア   | バージョン  | 備考        |
|:---------------|:------------|:------------|
| ruby      　　 | 2.2.0       |             |
| rails     　　 | 4.1.8       |             |
| postgres (PostgreSQL)   　　 |9.3.5        |             |
# 構成
+ [セットアップ(ローカル環境編)](#1)
+ [セットアップ(Docker on Mac編)](#2)
+ [セットアップ(Docker on Linux編)](#3)

# 詳細
## <a name="1">セットアップ(ローカル環境編)</a>
### rubyやrailsはインストール済とする

### Railsの環境をセットアップする
```bash
$ bundle install
```

### ポスグレをセットアップする
```bash
$ brew install postgresql
$ brew install postgis
```

### ローカルデータベースをセットアップする
```bash
$ postgres -D /usr/local/var/postgres/ &
$ bin/rake db:create
$ bin/rake db:migrate
```

### アプリケーションを起動する
```bash
$ bin/rails s
```
起動したらブラウザから_http://localhost:3000/_にアクセスして動作を確認する

## <a name="2">セットアップ(Docker on Mac編)</a>

### 前提
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| OS X           |10.8.5        |             |
| docker    　　 |1.4.1         |             |
| fig       　　 |1.0.1         |             |

### Dockerをインストールしていない場合は以下のリンクから対応するインストーラをダウンロードする
https://docs.docker.com/installation/#installation

### Dockerデーモンを起動する
```
$ boot2docker up
```
初回は以下のコマンドを実行しておく
```
$(boot2docker shellinit)
```

### Dockerを利用して開発する場合

あらかじめ fig をインストールしておく。
```
$ brew install fig
```

```
fig up
fig run web bin/rake db:setup
```

起動したら以下のコマンドでdockerのipアドレスが確認できるのでブラウザで_http://dockerのipアドレス:3000_アクセスして動作を確認する
```bash
$ boot2docker ip
192.168.59.103
```

アプリケーションの更新する場合は以下のコマンドを実行する
```bash
$ fig build
$ boot2docker restart
```

## <a name="3">セットアップ(Docker on Linux編)</a>

### 前提
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| Linux(CentOS)  | 6.6          | 下記ソフトが動作すれば、CentOSに限らない|
| docker    　　 | 1.5          |             |
| fig       　　 | 1.0.0        |             |

### Dockerインストール(インストールしていない場合)
```
$ sudo rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
$ sudo yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
$ sudo yum -y install docker-io 
```

### Dockerデーモンを起動する
```
$ sudo service docker start
$ sudo chkconfig docker on
```

### figインストール(インストールしていない場合)
```
$ sudo curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
```

### 開発環境起動
git pull後は最初にbuildする
```
$ fig build
$ fig up
```

### ターゲットAP起動
```
$ fig run web bin/rake db:setup
$ zcat coinpark.XXX.sql.gz|fig run web bin/rails dbconsole
```
    coinpark.XXX.sql.gzは、実験用の初期データをmysqldumpし、gzipアーカイブしたもの

### ターゲットAPへのアクセス
起動したホスト(例:basehost)の3000にポートマップされているので、
起動したホストにアクセスできるブラウザから
`http://basehost:3000/`
にアクセスして動作確認可能

### nsenterのインストール(インストールしていない場合)
コンテナでsshを動かしていなくても、コンテナへのシェルアクセスを可能にする
nsenterをインストールする
```
$ docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
```
### ターゲットマシン(コンテナ)へのシェルアクセス
```
$ sudo docker-enter parkmap_web_1
root@parkmap_web_1# 
```

# 参照
+ [PostGISを試してみる](http://blog.eiel.info/blog/2014/12/11/postgis-abc/)
+ [dockerをつかってrailsの開発をしてみる](http://qiita.com/eielh/items/754c1f785e66e3c4cee0)
+ [boot2docker + figで始めるDockerコンテナ・オーケストレーション](http://dev.classmethod.jp/server-side/docker-server-side/orchestration-with-boot2docker-fig/)
