#!/bin/sh

#Output to console in color
RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[0;34m'
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
#echo -e
echo
echo "\t${BLUE}$month${CLEAR} ${BROWN}$year${CLEAR}"
for d in ${days[@]}
do
	if [ $d == $day ]; then
		printf "${GREEN}"
	fi

	printf "$d ${CLEAR}"
done
echo

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


start=$((0 - $day1ref))
for (( i=$start; i <= $max; ++i ))
do
	if [ $i == $date ]; then
		printf "${RED}"
	fi

  if [ "$i" -lt 1 ]; then
    printf "    "
  elif [ "$i" -lt 10 ]; then
		printf " $i  ${CLEAR}"
	else
		printf "$i  ${CLEAR}"
	fi

  reali=$((i + day1ref+1))
	x=`expr $reali % 7`
	if [ $x == 0 ]; then 
    if [ $reali != 0 ] ; then
		  echo	
    fi
	fi
done
printf "${CLEAR}\n\n"

#echo -e "${GREEN}${day}${CLEAR}, ${BLUE}$month ${BROWN}$date${CLEAR}\n"
exit 0
