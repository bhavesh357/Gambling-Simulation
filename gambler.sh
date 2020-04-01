#!/bin/bash 
#constants
BETTING_AMOUNT=1

#variable
stake=100
target=0
stoploss=0
declare -a gamblingDays
declare -a profitLoss
continue=1
gamblingDays[0]=100
profitLoss[0]=0

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
	difference=$(($stake-$yesterdaysStack))
	if [ $stake -gt $yesterdaysStack ]
	then
		echo you have won $difference $day
	fi
	if [ $stake -lt $yesterdaysStack ]
	then
		echo you have lost $(($yesterdaysStack-$stake)) $day 
	fi
	if [ $stake -eq $yesterdaysStack ]
	then
		echo you have not won anything
	fi
	if [[ $(($index-1)) -eq $yesterdaysIndex ]]
	then
		profitLoss[$index]=$difference
	fi
}

function getLuckyAndUnluckiestDay() {
	unluckiest=0
	luckiest=0
	indexOfUnluckiest=0
	indexOfLuckiest=0
	for ((j=1;j<21;j++))
	do
	#finding smallest & largest
		currentDiff=${profitLoss[$j]} 
		if [ $currentDiff -lt $unluckiest ]
		then
			unluckiest=${profitLoss[$j]}
			indexOfUnluckiest=$j
		fi
		if [ $currentDiff -gt $luckiest ]
		then
			luckiest=${profitLoss[$j]}
			indexOfLuckiest=$j
		fi
	done
	echo your luckiest day was day $indexOfLuckiest where you won ${profitLoss[$indexOfLuckiest]}
	echo your unluckiest day was day $indexOfUnluckiest where you lost $((${gamblingDays[$(($indexOfUnluckiest-1))]}-${gamblingDays[$indexOfUnluckiest]}))
}

echo "Welcome to Gambling"
while [[ $continue -eq 1 ]] 
do
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
	if [ ${gamblingDays[0]} -lt ${gamblingDays[20]} ]
	then
		gamblingDays[0]=${gamblingDays[20]}
	else
		continue=0
	fi
done
checkReport 20 0 "this month"
echo ${gamblingDays[@]}
echo ${profitLoss[@]}
getLuckyAndUnluckiestDay
echo $stake