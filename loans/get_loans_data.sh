#!/bin/bash

# get latest loan data filenames from https://www.lendingclub.com/info/download-data.action
for i in LoanStats3a.csv.zip LoanStats3b.csv.zip LoanStats3c.csv.zip LoanStats3d.csv.zip LoanStats_2016Q1.csv.zip LoanStats_2016Q2.csv.zip LoanStats_2016Q3.csv.zip LoanStats_2016Q4.csv.zip LoanStats_2017Q1.csv.zip LoanStats_2017Q2.csv.zip LoanStats_2017Q3.csv.zip LoanStats_2017Q4.csv.zip LoanStats_2018Q1.csv.zip LoanStats_2018Q2.csv.zip; do
  wget https://resources.lendingclub.com/$i
  unzip $i
  rm $i
  csvfile=$(basename $i .zip)
  mv $csvfile $csvfile.tmp
  # remove first 2 and last 4 lines
  tail -n +3 $csvfile.tmp | head -n -4 > $csvfile
  rm $csvfile.tmp

  # 3a file has both types of data so just take funded loans before the title
  if [ "$i" == "LoanStats3a.csv.zip" ]; then
    mv $csvfile $csvfile.tmp
    sed '/^Loans that do not meet the credit policy/ q' $csvfile.tmp | head -n -3 > $csvfile
    rm $csvfile.tmp
  fi
done

# combine all files and gzip to save space
cat LoanStats3*.csv LoanStats_*.csv > LoanStats.csv
rm  LoanStats3*.csv LoanStats_*.csv
gzip LoanStats.csv
