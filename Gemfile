source "https://rubygems.org"

# Extra gems

# Additional gems

gem 'dotenv-rails'                        # Loads environment variables from a .env file
gem 'devise'                              # Flexible authentication solution for Rails
gem 'htmlbeautifier'                      # Beautifies HTML code
gem 'popper_js', '>= 2.9.3', '< 3.0.0'    # A kickass library used to manage poppers in web applications
gem 'bootstrap', '~> 5.3.3'               # Sleek, intuitive, and powerful front-end framework for faster and easier web development
gem 'jquery-rails'                        # jQuery! For Rails! So great
# gem 'simple_calendar'                   # A simple calendar for Rails
gem 'cancancan'                           # The authorization Gem for Ruby on Rails
gem 'image_processing', '~> 1.13'         # High-level image processing wrapper for libvips and ImageMagick/GraphicsMagick
gem 'active_storage_validations'          # ActiveStorage validations for Rails
gem 'mini_magick'                         # Manipulate images with minimal use of memory via ImageMagick / GraphicsMagick
gem "sidekiq", "~> 7.3"                   # Simple, efficient background processing for Ruby


gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"                        # PostgreSQL database adapter
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  
  # pry-byebug giving issues
  # gem 'pry-byebug', '~> 3.10', '>= 3.10.1'  # Adds step-by-step debugging and stack navigation capabilities to Pry
  gem 'byebug', '~> 11.1', '>= 11.1.3'

end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
