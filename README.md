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
