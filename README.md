# README

## How to run
`docker-compose up`

## How to stop
`docker-compose down`

## How to create db
`docker-compose run web rake db:create`

## Rebuild
`docker-compose up --build`

## Rebuild with bundle install
`docker-compose run web bundle install && docker-compose up --build`