# Homey Challenge
by David Lowenfels

This is a vanilla Rails 8 app using tailwind, slim, and rspec.

Comments and project status changes are tracked.
The db/seeds.rb sets up some random history for Project 1.
Project status is changed via the edit form, e.g. /projects/1/edit

Steps to get it running:
```
bundle install
rake db:create db:schema:load db:seed
bin/dev
```

Run the tests with: `rspec`
