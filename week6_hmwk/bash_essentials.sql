-- Read Ten Bash Essentials and answer the 8 questions at the end. Be sure you are in the ASDN_csv of the class data GitHub repository before answering the questions, as they rely on the files contained therein.

-- 1. Compare the output of these three commands and compare the outputs:
ls
ls .
ls "$(pwd)/../ASDN_csv"

    -- All three commands have the same output. The first one lists all the files in the directory I am in which is ASDN_csv. The second one (with the period) specifies to list the files in the current directory, which is the ASDN_csv. The last one specifies the file path to the ASDN_csv by going one level up and then going back into the ASDN_csv subdirectory which is also why it looks the same.

-- 2. Try the following two commands:
-- The first prints filenames and line counts. The second prints a bare number. Why does it print that number, and why does it not print any filenames?
wc -l *.csv
cat *.csv | wc -l

    -- The first line is counting all the lines in any file that ends in .csv, so it lists all the csv files and their line counts. The second command is concatenating all of the csv files into one entity and counts their lines. So, if you added the numbers from  the first count it should equal the number from the second command. It isn't printing any filenames because its not really a file, its just combined. 

-- 3. You want to count the total number of lines in all CSV files and try this command:
-- What happens and why?
cat *.csv | wc -l species.csv
    -- This command returns the number of lines from just the species.csv. Even though it was concatenated, that part is essentially ignored because it's prioritizing the specified file name. 

-- 4. You’re given and you’d like to print “Moe_Howard”. You try this:
-- but that doesn’t quite work. What fix can you apply to $name, while keeping it inside the quotation marks, to make this command give the desired effect?

name=Moe
echo "$name_Howard"

    -- fixed:
        echo "$name"_Howard""
-- 5. You create a script and run it like so:
-- What are the values of variables $1 and $#? Explain why the script does not see just one argument passed to it.
bash myscript.sh *.csv

    -- The variable $1 would be the first file ending in csv which is ASDN_Camp_assignment.csv, and $# is the number of csv files which would be 7. It sees more than one argument because of the wildcard (*); bash is looking at all of the csv files. 

-- 6. You create a script and run it like so:
-- In your script, what is the value of variable $3?

bash myscript.sh "$(date)" $(date)

    -- The $3 variable would represent the third word that is output from the date command. From the notes, it seems likely this would be "May".

-- 7. Create a file you don’t care about (because you’re about to destroy it):

echo "yo ho a line of text" > junk_file.txt
echo "another line" >> junk_file.txt

-- You want to sort the lines in this file, so you try:

sort junk_file.txt

-- Well that prints the lines in sorted order, but it doesn’t actually change the file. You recall section 7 and try:

sort junk_file.txt > junk_file.txt

-- What happens and why? How can you sort the lines in your file? (Hint: it involves creating a second file and using mv.)

    -- Running that last command empties the file out because > is destructive and overwrites any existing file with an empty one before the program is run. 

-- put lines back in file
echo "yo ho a line of text" > junk_file.txt
echo "another line" >> junk_file.txt

-- create temporary file to sort to and then put it back in original file
sort junk_file.txt > temp_file.txt
mv temp_file.txt junk_file.txt

-- 8. You want to delete all files ending in .csv, so you type (don’t actually try this):

rm * .csv

-- but as can be seen, your thumb accidentally hit the space bar and you got an extra space in there. What will rm do in this case?

    -- The extra space would essentially separate the wild card and the .csv, so it would try to remove all files and a file called .csv. 

