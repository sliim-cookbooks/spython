# Testing

Tests can be run with Rake:

#### Install dependencies
`bundle install`

#### Run Checkstyles
`bundle exec rake`

#### Foodcritic
`bundle exec rake test:foodcritic`

#### Cookstyle
`bundle exec rake test:cookstyle`

#### Kitchen
`bundle exec rake test:kitchen`

#### Kitchen in Docker
`KITCHEN_YAML=.kitchen.docker.yml bundle exec rake test:kitchen`
