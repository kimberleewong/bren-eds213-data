# Part 1: Make a "test harness" script that allows us to test timings repeatedly

# Example of a bash script
# % bash query_timer.sh label num_reps query db_file csv_file

# For example, you might run:

# % bash query_timer.sh with_index_a 1000 'SELECT COUNT(*) FROM Bird_nests' \
#     database.db timings.csv

#   Arguments:
#       label:    explanatory label that will be output
#       num_reps: number of repetitions
#       query:    SQL query to run
#       db_file:  database file
#       csv_file: CSV file to create or append to

# The following is pseudocode for the assigned task:

# get current time and store it
# loop num_reps times
#     duckdb db_file query
# end loop
# get current time
# compute elapsed time
# divide elapsed time by num_reps
# write output


# Input arguments
label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5


# Current time and store it
start_time=$(date +%s)


# Execute the query num_reps times
for i in $(seq "$num_reps"); do
    duckdb "$db_file" "$query" > /dev/null
done

# End time and store it
end_time=$(date +%s)

# Compute elapsed time
elapsed_time=$((end_time - start_time))

# Compute average time
avg_time=$(python -c "print($elapsed_time/$num_reps)")

# Append results to CSV
echo "$label,$num_reps,$elapsed_time,$avg_time" >> "$csv_file"

# Part 2
# I ran the test harness for the three queries 3 times each with different amount of repetitions (10, 100, 1000). The 1000 repititions were the most specific. The outer_join was the fastest with an average time of 0.044 seconds per repitition, but the other two methods were very close with except being 0.045 seconds and subquery being 0.046 seconds.

 