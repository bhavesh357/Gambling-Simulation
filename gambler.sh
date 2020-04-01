#constants
BETTING_AMOUNT=1

#variable
stake=100

function bet() {
	if [ $(($RANDOM%2)) -eq 0 ]
	then
		stake=$(($stake-$BETTING_AMOUNT))
	else
		stake=$(($stake+$BETTING_AMOUNT))
	fi
}

echo "Welcome to Gambling"
bet()