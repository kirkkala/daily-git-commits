#!/bin/bash

# Modify only these ########
author="Timo Kirkkala"
local_projects_directory_root="/Users/kirkkala/Sites"
############################

date="$1"
end=$(date -j -v +1d -f "%Y-%m-%d" "$2" +%Y-%m-%d)

#COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
#COLOR_YELLOW=$(tput setaf 3)
#COLOR_BLUE=$(tput setaf 4)
COLOR_MAGENTA=$(tput setaf 5)
COLOR_RESET=$(tput sgr0)

function getCommitsPerDate() {
  date="$1"

  find "$local_projects_directory_root" -name .git -type d -prune -maxdepth 3 -exec dirname {} \; | while read line; do
    logs=$(git -C "${line}" short --author="$author" |grep "$date")
    if [ "$logs" != "" ]; then
      echo -e "\n${COLOR_MAGENTA}${line}${COLOR_RESET}"
      echo "${logs//\ \+0300/}"
    fi
  done
}

while [ "$date" != "$end" ]; do
  echo -e "\n\n${COLOR_GREEN}#################\n$date${COLOR_RESET}"
  getCommitsPerDate "$date" "$author"
  date=$(date -j -v +1d -f "%Y-%m-%d" "$date" +%Y-%m-%d)
done
