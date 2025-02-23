web: bundle exec puma -C config/puma.rb
release: DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:schema:load db:seed
