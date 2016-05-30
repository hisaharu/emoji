#!/usr/bin/env bash
set -e

echo "len(token)=" ${#GITHUB_ACCESS_TOKEN}
env | grep -E '^CIRCLE_'

sudo apt-get install -y jq

UPLOAD_URL=$(
	curl \
		-f \
		-H "Authorization: token $GITHUB_ACCESS_TOKEN" \
		"https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/releases/tags/$CIRCLE_TAG" \
	| tee /dev/stderr \
	| jq '.upload_url'
)
UPLOAD_URL=$(
	echo $UPLOAD_URL \
	| sed -e 's/{?name,label}/?name=/g' \
	| sed -e 's/"//g'
)
printf "URL: %s\n", $UPLOAD_URL

curl \
	-f \
	--data-binary @$1 \
	-H "Content-Type: image/png" \
	-H "Authorization: token $GITHUB_ACCESS_TOKEN" \
	$UPLOAD_URL$2

