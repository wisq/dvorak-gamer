build: bundle
	bundle exec middleman build

server: bundle
	bundle exec middleman server

bundle:
	bundle check || bundle install

clean:
	rm -rf build/
