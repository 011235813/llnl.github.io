rebuild_jekyll:
	git commit --allow-empty -m"Trigger Jekyll rebuild"
	git push

clean:
	rm -rf _site/

build:
	bundle exec jekyll build
	bundle exec htmlproofer ./_site --check_html --check_img_http --disable_external --url-ignore "{{ repo.url }},{{ repo.url }}/network,{{ repo.url }}/stargazers,{{ licenseInfo.url }},{{ repo.homepageUrl }},rosecompiler.org"
	# bundle exec htmlproofer ./_site --enforce_https --check_html --check_img_http --disable_external --url-ignore "{{ repo.url }},{{ repo.url }}/network,{{ repo.url }}/stargazers,{{ licenseInfo.url }},{{ repo.homepageUrl }},rosecompiler.org"

deploy: clean build
	chmod -R ugo+rX _site/
	rsync -avz --delete _site/ typhon:/export/www/software-pre/html/
