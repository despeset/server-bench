oi=0
touch curl.txt
while true; do
	printf "\n"
	printf "$(($i + $oi * 50)) | "
	for i in {1..50}; do
		curl http://localhost:8000/hello/world 2>> ./curl.txt &
		printf "."
	done
	sleep 1
	if [ $(tail -50 ./curl.txt | grep -c "7") > 30 ]; then
		printf "Too many connection failures, pausing for 10 seconds."
		sleep 10
	fi
done
