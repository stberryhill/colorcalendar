#!/bin/sh

#Output to console in color
RED='\033[0;31m'
REDB='\033[1;31m'
PINK='\033[0;35m'
PINKB='\033[1;35m'
GREEN='\033[0;32m'
GREENB='\033[1;32m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BLUEB='\033[1;34m'
CYAN='\033[0;36m'
CYANB='\033[1;36m'
WHITE='\033[0;37m'
WHITEB='\033[1;37m'
WHITEBACK='\033[1;47m'
CLEAR='\033[0m'
year=`date '+%Y'`
month=`date '+%B'`
day=`date '+%a'`
date=`date '+%d'`
days=( "Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat" )

#Figure out if it's a leap year
#leap year if divisible by 4, or if divisible by 100 and by 400
isleap='false'
if [ `expr $year % 4` != 0 ] ; then
  : 
elif [ `expr $year % 400` == 0 ] ; then
  #is a leap year
  isleap='true'
elif [ `expr $year % 100` == 0 ] ; then
  :
else
  #it is a leap year
  isleap='true'
fi

echo
width=30
headerraw="╭───$month $year"
header="╭───${BLUEB}$month${CLEAR} ${BLUE}$year${CLEAR}"
size=${#headerraw}
spaces=$((width - size))
printf "$header"
for (( i=0; i < $spaces; ++i ))
do
  printf "─"
done
printf "╮\n│ "

for d in ${days[@]}
do
	if [ $d == $day ]; then
		printf "${GREENB}"
	fi

	printf "$d ${CLEAR}"
done
printf "│ \n"

#max represents the number of days in this month
max=31
if [ "$month" == "February" ] ; then
  if [ $isleap == 'true' ] ; then
    max=29
  else
    max=28
  fi
elif [ "$month" != "September" ] ; then
  max=30
elif ["$month" != "April" ] ; then
  max=30
elif [ "$month" != "June" ] ; then
  max=30
elif [ "$month" != "November" ]; then
  max=30
else
  max=31
fi

sun=0
mon=1
tue=2
wed=3
thu=4
fri=5
sat=6

ref=-1
if [ "$day" == "Sun" ] ; then
  ref=0
elif [ "$day" == "Mon" ] ; then
  ref=1
elif [ "$day" == "Tue" ] ; then
  ref=2
elif [ "$day" == "Wed" ] ; then
  ref=3
elif [ "$day" == "Thu" ] ; then
  ref=4
elif [ "$day" == "Fri" ] ; then
  ref=5
elif [ "$day" == "Sat" ] ; then
  ref=6
fi

remainder=`expr $date % 7`
if [ $remainder -gt $ref ] ; then
  ref=$((ref+7))
fi

day1ref=$((ref-remainder))
day1=${days[$day1ref]}


printf "│ "	
start=$((0 - $day1ref))
for (( i=$start; i <= $max; ++i ))
do
  #Highlight today's date in red
  if [ $((i)) == $((date)) ]; then
		printf "${RED}"
	fi

  #Make sure that everything is uniformly spaced apart
  if [ "$i" -lt 1 ]; then
    printf "    "
  elif [ "$i" -lt 10 ]; then
		printf " $i  ${CLEAR}"
	else
		printf "$i  ${CLEAR}"
	fi

  #Check to see if it's time to go to a new line
  reali=$((i + day1ref+1))
	x=`expr $reali % 7`
	if [ $x == 0 ]; then 
    if [ $reali != 0 ] ; then
		  printf "│\n│ "	
    fi
	fi
done

#Finish off last two lines of calendar border/box
printf "                            │\n"
printf "╰─────────────────────────────╯\n"
printf "${CLEAR}\n\n"

exit 0
