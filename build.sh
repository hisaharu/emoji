#!/bin/bash
curl -C- "http://fonts.gstatic.com/ea/notosansjapanese/v6/download.zip" -o noto.zip
unzip noto.zip
ls -lahFs
convert -size 128x128 xc:transparent -font ./NotoSansJP-Bold.otf -pointsize 64 -fill teal -annotate +0+56 'せや' -annotate +0+122 'な。' seyana.png

