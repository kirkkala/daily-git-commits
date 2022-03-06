#!/bin/bash

# Modify only these ########
author="Timo Kirkkala"
local_projects_directory_root="/Users/kirkkala/Sites"
############################

from="$1"
to="$2"

if [[ $# -eq 0 ]] ; then
  # No arguments passed, default from and to date on current day
  from=$(date +'%Y-%m-%d')
  to="$from"
fi

if [[ -z "$2" ]] ; then
  # No second argument, default the "to" date on current day
  to=$(date +'%Y-%m-%d')
fi

end=$(date -j -v +1d -f "%Y-%m-%d" "$to" +%Y-%m-%d)

#COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
#COLOR_YELLOW=$(tput setaf 3)
#COLOR_BLUE=$(tput setaf 4)
COLOR_MAGENTA=$(tput setaf 5)
COLOR_RESET=$(tput sgr0)

function getCommitsPerDate() {
  find "$local_projects_directory_root" -name .git -type d -prune -maxdepth 3 -exec dirname {} \; | while read line; do
    logs=$(git -C "${line}" short --author="$author" | grep "$from")
    if [ "$logs" != "" ]; then
      echo -e "\n${COLOR_MAGENTA}${line}${COLOR_RESET}"
      echo "${logs//\ \+0300/}"
    fi
  done
}

while [ "$from" != "$end" ]; do
  echo -e "\n\n${COLOR_GREEN}#################\n$author's commits on $from${COLOR_RESET}"
  getCommitsPerDate "$from" "$author"
  from=$(date -j -v +1d -f "%Y-%m-%d" "$from" +%Y-%m-%d)
done
