build: bundle
	bundle exec middleman build

server: bundle
	bundle exec middleman server

bundle:
	bundle check || bundle install

clean:
	rm -rf build/

test:
	BUNDLE_FROZEN="true" BUNDLE_WITHOUT="server:development" MM_ENV="production" $(MAKE) build

deploy:
	ssh-add -l | grep -iq ed25519 || ssh-add
	git push origin master
	rake deploy:wait
