#!/bin/bash
FILES=./data/mirna_read_count_by_experiment/*

rm -r ./results/*

for f in $FILES
do
  #echo "Processing $f file..."
  # take action on each file. $f store current file name
  
  filename=$(basename "$f")
  extension="${filename##*.}"
  filename="${filename%.*}"
  extok="fa"
  
  if [ "$extension" == "$extok" ]
  then
    arrFN=(${filename//_/ })
  
    ftype=${arrFN[-1]}
  
    #echo "${arrFN[-1]}"
  
    #echo $ftype
  
    echo "Processing $filename file with extension $extension..."

    java -jar miraligner.jar -sub 1 -trim 3 -add 3 -s $ftype -i $f -db DB  -o ./results/$filename

  fi
done 
