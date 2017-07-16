build: bundle
	bundle exec middleman build

server: bundle
	bundle exec middleman server

bundle:
	bundle check || bundle install

clean:
	rm -rf build/

test:
	BUNDLE_FROZEN="true" BUNDLE_WITHOUT="server:development" DEPLOYING=1 $(MAKE) build

deploy:
	git push origin master
	rake deploy:wait
