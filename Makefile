.PHONY: serve push

serve:
	bundle exec jekyll serve

push:
	git push origin master
