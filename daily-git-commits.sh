#!/bin/bash

# Load configuration from .env file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"

if [[ -f "$ENV_FILE" ]]; then
  # Source the .env file
  source "$ENV_FILE"
  author="$AUTHOR"
  local_projects_directory_root="$LOCAL_PROJECTS_DIRECTORY_ROOT"
else
  echo "⚠️  .env file not found at: $ENV_FILE"
  echo "Please create a .env file with the following variables:"
  echo "AUTHOR=\"Your Name\""
  echo "LOCAL_PROJECTS_DIRECTORY_ROOT=\"/path/to/your/projects\""
  exit 1
fi

COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
COLOR_YELLOW=$(tput setaf 3)
COLOR_BLUE=$(tput setaf 4)
COLOR_MAGENTA=$(tput setaf 5)
COLOR_RESET=$(tput sgr0)

if [[ ! -d $local_projects_directory_root ]]
then
  echo -e "${COLOR_RED}#################\nDIRECTORY DOES NOT EXIST: ${local_projects_directory_root}${COLOR_RESET}\n
Check the local_projects_directory_root variable\n"
  exit 0
fi

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

# Function to calculate display width of text with emojis
function getDisplayWidth() {
  local text="$1"
  # Use wc -m to get character count, then adjust for emoji display width
  local char_count=$(echo -n "$text" | wc -m | tr -d ' ')
  
  # Count our specific emojis
  local calendar_emoji_count=$(echo -n "$text" | grep -o '📅' | wc -l | tr -d ' ')
  local developer_emoji_count=$(echo -n "$text" | grep -o '👨‍💻' | wc -l | tr -d ' ')
  
  # 📅 displays as 2 characters but wc -m counts as 1, so add 1
  # 👨‍💻 is a compound emoji that displays as 2 but wc -m counts as 3 (man+zwj+computer), so subtract 1
  local display_len=$((char_count + calendar_emoji_count - developer_emoji_count))
  echo $display_len
}

function getCommitsPerDate() {
  local temp_file=$(mktemp)
  local found_commits=false
  
  find "$local_projects_directory_root" -name .git -type d -prune -maxdepth 3 -exec dirname {} \; | while read line; do
    logs=$(git -C "${line}" short --author="$author" | grep "$from")
    if [ "$logs" != "" ]; then
      # Extract just the project name from the full path
      project_name=$(basename "${line}")
      echo -e "\n${COLOR_BLUE}📂 ${project_name}${COLOR_RESET}"
      echo -e "${COLOR_MAGENTA}   └─ ${line}${COLOR_RESET}"
      
      # Process each commit log entry
      echo "${logs//\ \+0300/}" | while IFS= read -r commit_line; do
        if [ -n "$commit_line" ]; then
          # Extract time, message, and branch info
          time_part=$(echo "$commit_line" | cut -d'|' -f1 | xargs)
          message_and_branch=$(echo "$commit_line" | cut -d'|' -f2- | xargs)
          
          # Extract just the time (HH:MM:SS)
          time_only=$(echo "$time_part" | cut -d' ' -f2)
          
          echo -e "   ${COLOR_GREEN}🕒 ${time_only}${COLOR_RESET} ${COLOR_YELLOW}💻 ${message_and_branch}${COLOR_RESET}"
        fi
      done
      echo "found" > "$temp_file"
    fi
  done
  
  # Check if no commits were found and display a funny message
  if [ ! -f "$temp_file" ] || [ ! -s "$temp_file" ]; then
    funny_messages=(
      "🦗 *crickets chirping* - Looks like the code took a vacation day!"
      "🏖️ Even developers need beach days! No commits found."
      "🎯 Achievement Unlocked: Master of Procrastination!"
      "🦥 Embracing the sloth lifestyle - zero commits detected!"
      "🍕 Probably too busy deciding between pizza toppings to commit code."
      "🛌 The code is sleeping peacefully. Do not disturb."
      "🎮 Plot twist: Spent the day debugging... someone else's code!"
      "🦸‍♂️ Even superheroes have secret identity days (no commits)."
      "🎪 The commits ran away to join the circus!"
      "🔍 Commits are playing hide and seek... and winning!"
    )
    
    # Select a random funny message
    random_index=$((RANDOM % ${#funny_messages[@]}))
    echo -e "\n   ${COLOR_YELLOW}${funny_messages[$random_index]}${COLOR_RESET}"
  fi
  
  # Clean up temp file
  [ -f "$temp_file" ] && rm "$temp_file"
}

while [ "$from" != "$end" ]; do
  # Format the date nicely
  formatted_date=$(date -j -f "%Y-%m-%d" "$from" "+%B %d, %Y")
  day_of_week=$(date -j -f "%Y-%m-%d" "$from" "+%A")
  
  # Create the content lines
  date_line="📅 ${day_of_week}, ${formatted_date}"
  author_line="👨‍💻 ${author}'s coding adventures"
  
  # Calculate the display width of each line (accounting for emoji display width)
  date_display_len=$(getDisplayWidth "$date_line")
  author_display_len=$(getDisplayWidth "$author_line")
  
  # Find the longest line and set minimum width
  max_content_len=$((date_display_len > author_display_len ? date_display_len : author_display_len))
  min_width=60
  content_width=$((max_content_len > min_width ? max_content_len : min_width))
  
  # Total box width includes borders and padding
  box_width=$((content_width + 4))  # 2 for borders + 2 for minimum padding
  
  # Create dynamic borders
  border_line=""
  for ((i=0; i<box_width-2; i++)); do
    border_line+="═"
  done
  
  # Calculate padding for centering (ensuring both sides are equal)
  date_total_padding=$((box_width - date_display_len - 2))
  date_padding=$((date_total_padding / 2))
  date_right_padding=$((date_total_padding - date_padding))
  
  author_total_padding=$((box_width - author_display_len - 2))
  author_padding=$((author_total_padding / 2))
  author_right_padding=$((author_total_padding - author_padding))
  
  echo -e "\n\n${COLOR_GREEN}╔${border_line}╗"
  printf "${COLOR_GREEN}║%*s%s%*s║${COLOR_RESET}\n" $date_padding "" "$date_line" $date_right_padding ""
  printf "${COLOR_GREEN}║%*s%s%*s║${COLOR_RESET}\n" $author_padding "" "$author_line" $author_right_padding ""
  echo -e "${COLOR_GREEN}╚${border_line}╝${COLOR_RESET}"
  
  getCommitsPerDate "$from" "$author"
  
  # Add a nice separator line if there are more days to process
  next_date=$(date -j -v +1d -f "%Y-%m-%d" "$from" +%Y-%m-%d)
  if [ "$next_date" != "$end" ]; then
    echo -e "\n${COLOR_BLUE}════════════════════════════════════════════════════════════════════${COLOR_RESET}"
  fi
  
  from=$next_date
done
