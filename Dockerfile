FROM rails:onbuild

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password

RUN apt-get update && apt-get -y install npm && rm -rf /var/lib/apt/lists/*
RUN npm install
RUN nodejs node_modules/gulp/bin/gulp.js build
RUN rake assets:precompile

CMD ["rails", "server", "-b", "0.0.0.0"]
