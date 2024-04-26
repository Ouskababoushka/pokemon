# README

## Prerequisites

Before you begin, ensure you have met the following requirements:
- macOS operating system, you can use Hombrew to install the followings.
- Ruby version 3.1.2
- PostgreSQL installed (ensure it is running)
- Bundler installed (run `gem install bundler` if you don't have it)

## Installation

Follow these steps to get your development environment running:


   ```bash
   git clone https://yourrepositorylink.git
   cd yourrepositoryname

   # Install project dependencies
   bundle install
   # Create and migrate the database
   rails db:create db:migrate
   # Start the Rails server
   rails s
   # Now, open your web browser and go to http://localhost:3000

