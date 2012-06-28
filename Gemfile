source 'https://rubygems.org'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end

gem 'parslet'

group :development do
  gem 'rspec'
  gem 'guard-rspec'
end

gem 'growl', :require => darwin_only('growl')
