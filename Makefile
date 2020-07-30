all: local

dev  : host=dev.s11.no
prod : host=s11.no

local : dest=$(shell pwd)/public
dev prod : dest=/files/web/vhosts/${host}/


dev prod : base=https://${host}/
local : base=$(dest)

dev local : hugoopts = --ignoreCache --cleanDestinationDir --buildDrafts

local dev prod : hugo results

hugo:
	hugo ${hugoopts} --enableGitInfo --destination ${dest} --baseURL ${base}

results:
	#echo Deployed to ${base} at ${dest}
	xdg-open ${base}/index.html
	wait

server:
	(sleep 1 ; xdg-open http://localhost:1313)&
	hugo server --buildDrafts --baseURL http://localhost/ 

