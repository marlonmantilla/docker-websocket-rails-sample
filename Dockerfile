FROM ruby:2.2.3-slim
MAINTAINER Marlon Mantilla M. <marman0315@gmail.com>

RUN apt-get update \
		&& apt-get install -qq -y git build-essential nodejs libgmp-dev libev-dev libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

ENV INSTALL_PATH /websocket_test
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Set Rails to run in production
ENV RAILS_ENV production 
ENV RACK_ENV production

COPY . .

# RUN bundle exec rake websocket_rails:start_server --trace

# CMD tail -100f log/websocket_rails.log

CMD bundle exec rake websocket_rails:start_server --trace