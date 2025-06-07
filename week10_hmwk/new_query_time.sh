#!/bin/bash

label=$1
query=$2
sql_file=$3
csv_file=$4
index_columns=$5  
num_values_query=$6

# Create index name from label
index_name="idx_${label//[^a-zA-Z0-9]/_}"

# Create index when given index columns
if [ -n "$index_columns" ]; then
    echo "Creating index on column(s): $index_columns" 
    sqlite3 "$sql_file" "CREATE INDEX IF NOT EXISTS $index_name ON Bird_nests($index_columns);"
fi

# Get amount of distinct values
if [ -n "$num_values_query" ]; then
    num_distinct_values=$(sqlite3 -csv "$sql_file" "$num_values_query")
else
    num_distinct_values=1
fi

# Automate the number of repetitions
num_reps=1
while true; do
    start=$SECONDS
    for _ in $(seq $num_reps); do
        sqlite3 "$sql_file" "$query" > /dev/null
    done
    end=$SECONDS
    if [ $((end - start)) -gt 5 ]; then
        break
    fi
    echo "Too fast, trying again!"
    num_reps=$((num_reps * 10))
done

# Get start time
start_time=$(date +%s)

# Run timing loop with DuckDB
for ((i = 1; i <= num_reps; i++)); do
    sqlite3 "$sql_file" "$query" > /dev/null
done

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
avg_time=$(python -c "print(round($elapsed_time / $num_reps, 6))")

# Output to CSV
echo "$label,$num_reps,$elapsed_time,$avg_time,$num_distinct_values" >> "$csv_file"

# Drop index if it was created
if [ -n "$index_columns" ]; then
    echo "Dropping index $index_name"
    sqlite3 "$sql_file" "DROP INDEX IF EXISTS $index_name;"
fi