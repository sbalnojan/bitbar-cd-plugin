#!/bin/sh
# <bitbar.title>Death Clock</bitbar.title>
# <bitbar.version>v1.1</bitbar.version>
# <bitbar.author>Sven Balnojan</bitbar.author>
# <bitbar.author.github>sbalnojan</bitbar.author.github>
# <bitbar.desc>Shows time left to live.</bitbar.desc>
# <bitbar.dependencies></bitbar.dependencies>

# Dependencies:

if [ -z "$1" ]
  then
    . ~/.dc_config.cfg
else
    . .dc_config.cfg
fi


#DEATH_DATE_STR="2020-11-07"
DEATH_DATE=$(date -jf "%Y-%m-%d" $DEATH_DATE_STR)
DEATH_SEC=$(date -jf "%Y-%m-%d" ${DEATH_DATE_STR} +"%s")

CURR_DATE=$(date)
CURR_SEC=$(date +"%s")

DIFF=$(((DEATH_SEC - CURR_SEC)/(86400)))
PROJ=$((DIFF/(365*4)))
YEARS=$((DIFF/365))
DAYS_THIS_YEAR=$((DIFF-YEARS*365))

# prints the progress of the current quarter
#
# Examples:
# print_quarter_prog 250
#   Returns: 22%
#
function print_quarter_prog {
  DAYS_THIS_YEAR=$1

  if [[ "$DAYS_THIS_YEAR" -gt "270" ]]
    then
      echo "$(( (365-DAYS_THIS_YEAR)*100/90 ))%"
  elif [[ "$DAYS_THIS_YEAR" -gt "180" && "$DAYS_THIS_YEAR" -lt "270" ]]
    then
      echo "$(( (270-DAYS_THIS_YEAR)*100/90 ))%"
  elif [[ "$DAYS_THIS_YEAR" -gt "90" && "$DAYS_THIS_YEAR" -lt "180" ]]
    then
      echo "$(( (180-DAYS_THIS_YEAR)*100/90 ))%"
  else
      echo "$(( (DAYS_THIS_YEAR)*100/90 ))%"
  fi
}

if [[ QUARTER_PROGRESS ]]
  then
    ADD_THIS="($( print_quarter_prog $DAYS_THIS_YEAR ))"
    ADD_THAT="$( print_quarter_prog $DAYS_THIS_YEAR ) left of quarter"
fi

echo "${DIFF} days ${ADD_THIS}"
echo "---"
if [[ -n $ADD_THAT ]]; then
  echo $ADD_THAT
fi

echo "${PROJ} projects"

if [ -n "$BOOKS_A_YEAR" ]
  then
    BK=$((BOOKS_A_YEAR * DIFF/365))
    echo "${BK} books"
fi
