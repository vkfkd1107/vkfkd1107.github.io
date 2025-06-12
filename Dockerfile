FROM ruby:3.1-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--watch"]
