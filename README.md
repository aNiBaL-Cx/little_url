# README

Steps to get the application up and running.

* Ruby version 
    - 2.7.0
* System dependencies 
    - developement was done using sqlite3
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
