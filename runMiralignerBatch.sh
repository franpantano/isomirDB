#!/bin/bash
FILES=$1*

#rm -r $2*

for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  
  filename=$(basename "$f")
  extension="${filename##*.}"
  filename="${filename%.*}"
  
  arrFN=(${filename//_/ })
  
  ftype=${arrFN[-1]}
  
  #echo "${arrFN[-1]}"
  
  #echo $ftype
  
  #echo "Processing $filename file..."

  java -jar miraligner.jar -sub 1 -trim 3 -add 3 -s $ftype -i $f -db DB  -o $2$filename
done 
