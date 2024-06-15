FROM ruby:3.0.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client vim firefox-esr
RUN yarn install --check-files
RUN yarn add bootstrap jquery popper.js

WORKDIR /mrl
COPY Gemfile /mrl/Gemfile
COPY Gemfile.lock /mrl/Gemfile.lock
RUN bundle install
RUN rails webpacker:install

COPY . /mrl

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
