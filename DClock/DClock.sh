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
CURR_DATE=$(date)
echo $CURR_DATE
echo $DEATH_DATE
