FROM ruby:3.1.2-alpine AS base

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base gnupg git postgresql-client"
ARG DEV_PACKAGES="postgresql-dev"
ARG RUBY_PACKAGES="tzdata"

ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

RUN gem update --system && gem install bundler

COPY Gemfile* ./

COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN bundle config --global frozen 1 without 'development:test:assets' set path 'vendor/bundle' \
    && bundle install -j4 --retry 3

COPY . .
RUN bin/rails assets:precompile
RUN rm -rf tmp/cache app/assets vendor/assets

FROM ruby:3.1.2-alpine AS package

ARG RAILS_ROOT=/app
ARG PACKAGES="tzdata postgresql-client bash"

ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

COPY --from=base $RAILS_ROOT $RAILS_ROOT

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
