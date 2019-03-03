#!/bin/sh
# <bitbar.title>Death Clock</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Sven Balnojan</bitbar.author>
# <bitbar.author.github>sbalnojan</bitbar.author.github>
# <bitbar.desc>Shows time left to live.</bitbar.desc>
# <bitbar.dependencies></bitbar.dependencies>

# Dependencies:
#   jq (https://stedolan.github.io/jq/)

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
if [[ QUARTER_PROGRESS ]]
  then
    echo "QUARTER PROGRESS active."
    echo "${YEARS} years"
    echo "${DAYS_THIS_YEAR} days this year"
    if [[ "$DAYS_THIS_YEAR" -gt "270" ]]
      then
        echo "Quarter 4"
    elif [[ "$DAYS_THIS_YEAR" -gt "180" && "$DAYS_THIS_YEAR" -lt "270" ]]
      then
        echo "Quarter 3"
    elif [[ "$DAYS_THIS_YEAR" -gt "90" && "$DAYS_THIS_YEAR" -lt "180" ]]
        echo "Quarter 2"
    else
        echo "Quarter 1"
fi

echo "${DIFF} days"
echo "---"
echo "${PROJ} projects"

if [ -n "$BOOKS_A_YEAR" ]
  then
    BK=$((BOOKS_A_YEAR * DIFF/365))
    echo "${BK} books"
fi
