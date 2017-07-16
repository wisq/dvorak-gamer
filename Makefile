build: bundle
	bundle exec middleman build

deploy: build
	bundle exec middleman s3_sync

server: bundle
	bundle exec middleman server

bundle:
	bundle check || bundle install
