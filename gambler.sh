#!/bin/bash 
#constants
BETTING_AMOUNT=1

#variable
stake=100
target=0
stoploss=0
declare -a gamblingDays
gamblingDays[0]=100

function bet() {
	if [ $(($RANDOM%2)) -eq 0 ]
	then
		stake=$(($stake-$BETTING_AMOUNT))
	else
		stake=$(($stake+$BETTING_AMOUNT))
	fi
}

function setTargetStoploss() {
	target=$(($stake+$(($stake/2))))
	stoploss=$(($stake-$(($stake/2))))
}

function checkReport() {
	index=$1
	yesterdaysIndex=$2
	day=$3
	yesterdaysStack=${gamblingDays[$yesterdaysIndex]}
	if [ $stake -gt $yesterdaysStack ]
	then
		echo you have won $(($stake-$yesterdaysStack)) $day
	fi
	if [ $stake -lt $yesterdaysStack ]
	then
		echo you have lost $(($yesterdaysStack-$stake)) $day 
	fi
	if [ $stake -eq $yesterdaysStack ]
	then
	
		echo you have not won anything
	fi
}

echo "Welcome to Gambling"
for((i=1;i<21;i++))
do	
	setTargetStoploss
	while [[ $stake -ne $target && $stake -ne $stoploss ]]
	do
		bet
	done
	gamblingDays[i]=$stake
	checkReport $i $(($i-1)) "on day $i"
done
checkReport 20 0 "this month"
echo $stake