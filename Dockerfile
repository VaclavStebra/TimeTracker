FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /timetracker
WORKDIR /timetracker
COPY Gemfile /timetracker/Gemfile
COPY Gemfile.lock /timetracker/Gemfile.lock
RUN bundle install
COPY . /timetracker
