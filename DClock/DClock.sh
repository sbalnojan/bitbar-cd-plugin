#!/bin/sh
# <bitbar.title>Death Clock</bitbar.title>
# <bitbar.version>v1.1</bitbar.version>
# <bitbar.author>Sven Balnojan</bitbar.author>
# <bitbar.author.github>sbalnojan</bitbar.author.github>
# <bitbar.desc>Shows time left to live.</bitbar.desc>
# <bitbar.dependencies></bitbar.dependencies>

# Dependencies:

# prints the progress of the current quarter
#
# Examples:
# print_quarter_prog 250
#   Returns: 22%
#
function print_quarter_prog {
  local days_this_year=$1

  if [[ "${days_this_year}" -gt "270" ]]; then
      echo "$(( (365-days_this_year)*100/90 ))%"
  elif [[ "${days_this_year}" -gt "180" && "${days_this_year}" -lt "270" ]]; then
      echo "$(( (270-days_this_year)*100/90 ))%"
  elif [[ "${days_this_year}" -gt "90" && "${days_this_year}" -lt "180" ]]; then
      echo "$(( (180-days_this_year)*100/90 ))%"
  else
      echo "$(( (days_this_year)*100/90 ))%"
  fi
}

function main {
  if [[ -z "$1" ]]; then
      . ~/.dc_config.cfg
  else
      . .dc_config.cfg
  fi

  DEATH_DATE=$(date -jf "%Y-%m-%d" ${DEATH_DATE_STR})
  DEATH_SEC=$(date -jf "%Y-%m-%d" ${DEATH_DATE_STR} +"%s")

  curr_date=$(date)
  curr_sec=$(date +"%s")

  diff=$(((DEATH_SEC - curr_sec)/(86400)))
  proj=$((diff/(365*4)))
  years=$((diff/365))
  days_this_year=$((diff-years*365))

  if [[ QUARTER_PROGRESS ]]; then
      add_this="($( print_quarter_prog $days_this_year ))"
      add_that="$( print_quarter_prog $days_this_year ) left of quarter"
  fi

  echo "${diff} days ${add_this}"
  echo "---"
  if [[ -n "${add_that}" ]]; then
    echo $add_that
  fi

  echo "${proj} projects"

  if [ -n "${BOOKS_A_YEAR}" ]; then
      bk=$((BOOKS_A_YEAR * diff/365))
      echo "${bk} books"
  fi
}

main "$@"
