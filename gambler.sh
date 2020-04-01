#!/bin/bash -x
#constants
BETTING_AMOUNT=1

#variable
stake=100
target=0
stoploss=0

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

echo "Welcome to Gambling"
setTargetStoploss
while [[ $stake -ne $target && $stake -ne $stoploss ]]
do
	bet
done
echo $stake