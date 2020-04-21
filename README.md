# README

Steps to get the application up and running.

* Ruby version 
    - 2.7.0
* Node version
    - 12.5.0
* System dependencies 
    - developement was done using sqlite3
    - install the bundler gem 
    - install yarn
* setting up development environment
    - bundle install
    - yarn install
* Configuration
    - the database configuration file is exceptionaly in the project for demonstration purposes 
* Database creation 
    - rake db:create
* Database initialization
    - RAILS_ENV=development rake db:migrate
    - RAILS_ENV=test rake db:migrate
* How to run the test suite
    - testing was implemented using rspec
    - to run test suite run : rake
* How to run the development server
    - bundle exec bin/rails s
    - ./bin/webpack-dev-server