FROM ruby:3.0.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client vim #chromium=89.0.4389.114-1~deb10u1
RUN yarn install --check-files
RUN yarn add bootstrap jquery popper.js

#RUN wget -N http://chromedriver.storage.googleapis.com/89.0.4389.23/chromedriver_linux64.zip -P ~/
#RUN unzip ~/chromedriver_linux64.zip -d ~/
#RUN rm ~/chromedriver_linux64.zip
#RUN mv -f ~/chromedriver /usr/local/bin/chromedriver
#RUN chown root:root /usr/local/bin/chromedriver
#RUN chmod 0755 /usr/local/bin/chromedriver
#ENV PATH="/usr/local/bin/chromedriver:${PATH}"

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
