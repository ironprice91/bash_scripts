#!/bin/bash

# Imgur upload endpoint docs: http://api.imgur.com/endpoints/image
# Client Id link: https://api.imgur.com/oauth2/addclient
client_id="CLIENT_ID_HERE"
imgur_upload_url="https://api.imgur.com/3/image"
base64_img=`base64 "$1"`

write_base64() {
  echo $base64_img > /tmp/imgur_base64.txt
}

if [ ! -f /tmp/imgur_base64.txt ]; then
  write_base64
else
  rm -rf /tmp/imgur_base64.txt
  write_base64
fi

res=`curl -sH "Authorization: Client-ID $client_id" -d @/tmp/imgur_base64.txt "$imgur_upload_url"`


if [ $(echo $res | grep -c "\"success\":true") -gt 0 ]; then
  link=$(echo $res | sed -e 's/.*"link":"\([^"]*\).*/\1/' -e 's/\\//g')
  echo "Copied to clipboard: "$link
  echo $link | pbcopy
fi


# imgur_upload
# simple bash script to upload local image to imgur and copy link to clipboard

# To use, call the script and pass an image as your argument. <br>

# e.g.
# ```
# ./imgur_upload.sh img_path_here
# ```