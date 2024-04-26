# README

## Prerequisites
Before you begin, ensure you have met the following requirements:
- **Operating System**: macOS
- **Ruby**: Version 3.1.2. You can use Homebrew to install Ruby if it's not already installed:
  ```bash
  brew install ruby
  
  # PostgreSQL: Ensure it is installed and running. Install it via Homebrew if needed:
  brew install postgresql
  brew services start postgresql
  
  #Bundler: Required for managing Ruby gems. Install it if you haven't already :
  gem install bundler


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

