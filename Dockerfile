FROM rails:onbuild

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password
ENV DATABASE_URL postgis://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db/coinpark

RUN rake assets:precompile

CMD ["rails", "server", "-b", "0.0.0.0"]
