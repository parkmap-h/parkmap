FROM rails:onbuild

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password

RUN rake assets:precompile

CMD ["rails", "server", "-b", "0.0.0.0"]
