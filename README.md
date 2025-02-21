# Homey Challenge
by David Lowenfels

This is a vanilla Rails 8 app using tailwind, slim, and rspec.

Steps to get it running:
```
bundle install
rake db:create db:schema:load db:seed
bin/dev
```

Run the tests with: `rspec`