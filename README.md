パークマップ
===
# 目的
広島の近隣の駐車場を探せるようにする

# 前提
| ソフトウェア     | バージョン    | 備考         |
|:---------------|:-------------|:------------|
| OS X           |10.8.5        |             |
| ruby      　　 |2.2.0        |             |
| rails     　　 |4.1.8        |             |
| docker    　　 |1.4.1        |             |
| fig       　　 |1.0.1        |             |
| postgres (PostgreSQL)    　　 |9.3.5        |             |
# 構成
+ [セットアップ(ローカル環境編)](#1)
+ [セットアップ(Docker編)](#2)
+ [セットアップ(Vagrant編)](#3)

# 詳細
## <a name="1">セットアップ</a>
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

## <a name="2">セットアップ(Docker編)</a>
Dockerをインストールしていない場合は以下のリンクから対応するインストーラをダウンロードする
https://docs.docker.com/installation/#installation

Dockerデーモンを起動する
```
$ boot2docker up
```
初回は以下のコマンドを実行しておく
```
$(boot2docker shellinit)
```

Dockerを利用して開発する場合

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

## <a name="3">セットアップ(Vagrant編)</a>

# 参照
+ [PostGISを試してみる](http://blog.eiel.info/blog/2014/12/11/postgis-abc/)
+ [dockerをつかってrailsの開発をしてみる](http://qiita.com/eielh/items/754c1f785e66e3c4cee0)
+ [boot2docker + figで始めるDockerコンテナ・オーケストレーション](http://dev.classmethod.jp/server-side/docker-server-side/orchestration-with-boot2docker-fig/)
