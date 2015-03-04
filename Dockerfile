FROM eiel/parkmap:bundle

COPY . /usr/src/app

RUN bundle install
RUN npm install
RUN nodejs node_modules/gulp/bin/gulp.js build --production
RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
