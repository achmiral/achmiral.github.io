default: serve 

i install:
	bundle config set --local path vendor/bundle
	bundle install

s serve:
	bundle exec jekyll serve --livereload --trace

p push:
	git push origin master

h help:
	@egrep '^\S|^$$' Makefile
