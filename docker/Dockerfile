ARG RUBY_VERSION=2.5.1

FROM ruby:$RUBY_VERSION-slim-stretch

ARG BUNDLER_VERSION=1.17.3
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_MAJOR=12

# Dist upgrade
RUN apt-get update -yqq \
  && apt-get -yq dist-upgrade

# Common dependencies
# curl is used to add new references to sources list
# libfontconfig is required by PhantomJS
# libpq-dev is required by gem pg2
# openssh-client gnupg2 required to add git credentials
RUN apt-get update -qq \
  && apt-get install -yqq --no-install-recommends \
  apt-transport-https \
  build-essential \
  curl \
  gnupg2 \
  libfontconfig \
  libpq-dev \
  openssh-client

# Add NodeJS to sources list
RUN curl -sSL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install Core Application dependencies
RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
  git \
  nodejs \
  unzip \
  wget

# Clear temporary files of installation
RUN apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# # Install phantomjs (there will be no new versions of PhantomJS, so it is safe to fix the last version)
ARG PHANTOMJS_VERSION=2.1.1
RUN mkdir -p /srv/var \
  && curl -sSL -o /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
  && tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp \
  && rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
  && mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs \
  && ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs

# Define timezone
RUN echo "America/Sao_Paulo" > /etc/timezone \
  && rm -f /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata

# Add github credentials on build
RUN mkdir /root/.ssh/
COPY docker/id_rsa_bundle /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa \
  && touch /root/.ssh/known_hosts \
  && ssh-keyscan github.com >> /root/.ssh/known_hosts

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_BIN=/usr/src/gems/bin \
  BUNDLE_JOBS=4 \
  BUNDLE_PATH=/usr/src/gems \
  BUNDLE_RETRY=3 \
  GEM_HOME=/usr/src/gems

# Upgrade RubyGems and install required Bundler version
RUN gem update --system \
  && gem install bundler:$BUNDLER_VERSION

# Run binstubs without prefixing with `bin/` or `bundle exec`
ENV PATH=$PATH:$BUNDLE_BIN

# Create a directory for the app code
RUN mkdir -p /app

WORKDIR /app

# Install gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
