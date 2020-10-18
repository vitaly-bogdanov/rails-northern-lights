source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# bundle install --without=production - запускаем в режиме разработки

gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate'
gem 'devise'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'mini_magick', '~> 4.8'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'materialize-sass', '~> 1.0.0'
gem 'whenever', require: false
gem 'sitemap_generator', '~> 6.1', '>= 6.1.2'
gem 'friendly_id', '~> 5.2.4'
gem 'babosa'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
# AWS S3 для хранения картинок
#gem "aws-sdk-s3", require: false
# ИЛИ
# Google Cloud Storage для хранения картинок
gem 'google-cloud-storage', require: false
group :production do
  gem 'pg'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', '~> 2.12'
  gem 'sqlite3'
end
group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'factory_bot_rails', '~> 6.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
