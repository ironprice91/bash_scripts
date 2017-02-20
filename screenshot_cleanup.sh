#!/bin/bash
# script to move any screenshot starting with the word Screen*.png (made for cmd+shift+4 screenshots for osx) to a screenshot_archive folder

DEFAULT_DIR="cd ~/Desktop/"
SCREENSHOT_ARCHIVE_DIR="screenshot_archive"

eval ${DEFAULT_DIR}

if [ ! -d "$SCREENSHOT_ARCHIVE_DIR" ];
    then
    mkdir "$SCREENSHOT_ARCHIVE_DIR"
fi

find . -maxdepth 1 -name 'Screen*.png' -print0 | while IFS= read -r -d $'\0' line; do
  MOD_DATE=`stat -f "%Sm" "$line"`

  DATE_DIR=`echo ${MOD_DATE} | sed -e 's/\( \).*\( \)/-/g'`

  if [ ! -d "$DATE_DIR" ];
    then
    mkdir -p "${SCREENSHOT_ARCHIVE_DIR}/${DATE_DIR}"
  fi

  if [ "$DATE_DIR" = "$DATE_DIR" ];
    then
    mv "$line" "${SCREENSHOT_ARCHIVE_DIR}/${DATE_DIR}"
  fi

done

osascript -e 'display notification "Done archiving images" with title "screenshot_cleaup.sh done"'

# example crontab: every Friday at 5PM
# run crontab -e
# 00 17 * * 5 zsh ~/path/to/screenshot_cleanup.sh > /dev/null 2>&1

exit
