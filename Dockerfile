FROM rails:onbuild

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password

RUN rake assets:precompile
RUN npm install
RUN node_modules/gulp/bin/gulp.js build

CMD ["rails", "server", "-b", "0.0.0.0"]
