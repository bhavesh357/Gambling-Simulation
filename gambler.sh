#!/bin/bash -x
#constants
BETTING_AMOUNT=1

#variable
stake=100
target=0
stoploss=0
declare -a gamblingDays

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
	if [ $stake -gt 100 ]
	then
		echo you have won $(($stake-100))
	fi
	if [ $stake -lt 100 ]
	then
		echo you have lost $((100-$stake))
	else
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
done
checkReport
echo $stake