oi=0
REPS=200
echo "" > curl.txt
while true; do
	printf "\n"
	let TOTAL=$oi*$REPS
	printf "$TOTAL | "
	for i in $( seq 1 $REPS); do
		curl http://localhost:8000/hello/world 2>> ./curl.txt &
		printf "."
	done
	sleep 0.8
	FAILURES=$(tail -50 ./curl.txt | grep -c "7")
	if [ $FAILURES -gt 30 ]; then
		printf "Too many connection failures ($FAILURES/50), pausing for 10 seconds."
		sleep 10
	fi
	let oi=$oi+1
done
