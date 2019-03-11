#!/bin/sh
# <bitbar.title>Death Clock</bitbar.title>
# <bitbar.version>v1.1</bitbar.version>
# <bitbar.author>Sven Balnojan</bitbar.author>
# <bitbar.author.github>sbalnojan</bitbar.author.github>
# <bitbar.desc>Shows time left to live.</bitbar.desc>
# <bitbar.dependencies></bitbar.dependencies>

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

# prints full years left till some date.
#
# Examples:
# date +"%Y" >> 2019
# calc_full_years_left "2025-01-25"
#   Returns: 5
#
function calc_full_years_left {
  local death_date=$1
  DEATH_YEAR=$(date -jf "%Y-%m-%d" ${DEATH_DATE_STR} +"%Y")
  CUR_YEAR=$(date +"%Y")
  echo $((DEATH_YEAR-CUR_YEAR))
}

# prints year to some date
#
# Examples:
# death_year "2025-01-25"
#   Returns: 2025
#
function death_year {
  local death_date=$1
  DEATH_YEAR=$(date -jf "%Y-%m-%d" ${death_date} +"%Y")
  echo "${DEATH_YEAR}"
}

# prints days left till some date
#
# Examples:
# date +"%Y-%m-%d" >> 2019-01-01

# calc_days_left "2019-01-25"
#   Returns: 24
#
function calc_days_left {
  local DEATH_DATE_STR=$1
  local DEATH_DATE=$(date -jf "%Y-%m-%d" ${DEATH_DATE_STR})
  local DEATH_SEC=$(date -jf "%Y-%m-%d" ${DEATH_DATE_STR} +"%s")

  local curr_date=$(date)
  local curr_sec=$(date +"%s")

  local diff=$(((DEATH_SEC - curr_sec)/(86400)))
  echo ${diff}
}

# prints days progressed this year
#
# Examples:

# calc_days_this_year "2019-01-25"
#   Returns: 24
#
function calc_days_this_year {
  calc_death_date=$1
  DEATH_YEAR=$(death_year ${calc_death_date})
  DAY=$(date -jf "%Y" ${DEATH_YEAR} +"%Y-01-01")
  b="$( calc_days_left $DAY )"
  a="$( calc_days_left ${calc_death_date} )"
  local DAYS_THIS_YEAR=$((a-b))
  echo "$(( 365-$DAYS_THIS_YEAR))"
}

function main {
  if [[ -z "$1" ]]; then
      . ~/.dc_config.cfg
  else
      . .dc_config.cfg
  fi

  diff="$( calc_days_left $DEATH_DATE_STR )"
  proj=$((diff/(365*4)))
  years=$((diff/365))

  days_this_year="$( calc_days_this_year ${DEATH_DATE_STR} )"

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
