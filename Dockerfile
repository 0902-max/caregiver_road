# Use the official Ruby image
FROM ruby:3.2.2

# Set the working directory
WORKDIR /myapp

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install Rails
RUN gem install rails -v '7.0.4'

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
# Install gems
RUN bundle install


# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]
