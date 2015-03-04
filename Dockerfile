FROM ruby:2.2.0

RUN apt-get update && apt-get install -y nodejs npm --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# ある程度やっておくことで高速化
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install
COPY package.json /usr/src/app/
RUN npm install
