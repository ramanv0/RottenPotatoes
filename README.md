# Rotten Tomatoes Clone
A Rotten Tomatoes clone written in Ruby using the Ruby on Rails framework. It allows users to browse movies, view movie details, and leave reviews.

## Installation
1. Install Ruby (version 2.6.6 or later) and Ruby on Rails (version 4.2.11 or later).
2. Clone this repository using `git clone https://github.com/ramanv0/RottenPotatoes.git`.
3. Navigate to the project directory and run `bundle install` to install the required gems.
4. Run rails `db:migrate` to set up the database.
5. Run `rails db:seed` to load the seed data into the database.
6. Run `rails s` to start the server.
7. Open your web browser and go to http://localhost:3000 to view the application.

## Usage
As a user, you can:
- Browse movies by title, rating, release date, etc.
- View details for a specific movie
- CRUD reviews for movies

By default, the application comes with a pre-populated list of movies, but you can add your own movies as a user.

## Testing
This project includes both Cucumber (written with Gherkin syntax) and RSpec tests.

To run the Cucumber tests, use the following command: `bundle exec cucumber`. The Cucumber tests and step definitions are located in the `features` directory.

To run the RSpec tests, use the following command: `bundle exec rspec`. The RSpec tests are located in the `spec` directory.
