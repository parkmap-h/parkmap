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

Dockerを利用して開発する場合

```
bin/docker_support db
bin/docker_support build
bin/docker_support bash
bin/rake db:setup
bin/rails s
```

`bin/docker_support`とするだけでもrails sを起動します。

Gemfileを変更したら`bin/docker_support build`を実行してください。

## <a name="3">セットアップ(Vagrant編)</a>

# 参照
+ [PostGISを試してみる](http://blog.eiel.info/blog/2014/12/11/postgis-abc/)
+ [dockerをつかってrailsの開発をしてみる](http://qiita.com/eielh/items/754c1f785e66e3c4cee0)
