#!/bin/bash

label=$1
query=$2
db_file=$3
csv_file=$4

# get current time and store it
start_time=$(date +%s)

# Automate the number of repetitions
num_reps=1
while true; do
    start=$SECONDS
    for _ in $(seq $num_reps); do
        sqlite3 $db_file "$query" >& /dev/null
    done
    end=$SECONDS
    if [ $((end - start)) -gt 5 ]; then
        break
    fi
    echo "Too fast, trying again!"
    num_reps=$((num_reps * 10))
done

# loop num_reps times
for ((i = 1; i <= num_reps; i++)); do
#     duckdb db_file query
    duckdb "$db_file" "$query" > /dev/null
# end loop
done

# get current time
end_time=$(date +%s)

# Fixed time calculation!
elapsed_time=$((end_time - start_time)) 

# divide elapsed time by num_reps
avg_time=$(python -c "print($elapsed_time / $num_reps)")

# write output
echo "$label,$num_reps,$elapsed_time,$avg_time" >> "$csv_file"