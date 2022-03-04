#!/bin/bash

# Modify only these ########
author="Timo Kirkkala"
local_projects_directory_root="/Users/kirkkala/Sites"
############################

date="$1"
end=$(date -j -v +1d -f "%Y-%m-%d" $2 +%Y-%m-%d)
RED='\033[0;31m'
NC='\033[0m'

function getCommitsPerDate() {
  date="$1"
  author="$2"
  YELLOW='\033[1;33m'
  CYAN='\033[0;36m'
  NC='\033[0m'

  echo -e "${YELLOW}${i}${NC}"
  find "$local_projects_directory_root" -name .git -type d -prune -maxdepth 3 -exec dirname {} \; | while read line; do
    logs=$(git -C "${line}" short --author="$author" |grep "$date")
    if [ "$logs" != "" ]; then
      echo -e "\n${CYAN}${line}${NC}"
      echo "${logs//\ \+0300/}"
    fi
  done
}

while [ "$date" != "$end" ]; do
  echo -e "\n\n${RED}################# $date #################${NC}"
  getCommitsPerDate $date $author
  date=$(date -j -v +1d -f "%Y-%m-%d" $date +%Y-%m-%d)
done
