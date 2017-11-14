#!/usr/bin/env bash

function general_error_with {
  echo $1
  echo "Przykład: script.sh [-a] plik.txt [kolumna1 kolumna2]"
  exit 1
}

function build_error_with {
  echo $1
  exit 2
}

function awk_counter {
  sum_column=`awk -v x=$1 '{y+=$x} END {print y}' $file`
  # sumowanie kolumny do jednej zmiennej
  echo $sum_column

  if [ $sum_result_flag ]; then
    let result_columns+=$sum_column
  fi
}

if [[ "$#" = 0 ]]; then
  general_error_with "Nie podałeś żadnego argumentu"
fi

if [[ "$1" =~ "-" ]]; then
  if [[ "$1" = '-a' ]]; then
    sum_result_flag=true
    shift
  else
    general_error_with "Zła opcja, popraw składnię"
  fi
fi

if [[ "$#" = 0 ]]; then
  general_error_with "Za mało argumentów, podaj nazwę pliku"
else
  file=$1
  shift
fi

if [ ! -f $file ]; then
  build_error_with "Podany plik nie istnieje"
fi

if [ ! -r $file ]; then
  build_error_with "Brak odpowiednich praw dostępu do pliku"
fi

if [ $# -eq 0 ]; then # gdy nie podano żadnych kolumn
  awk_counter 1
fi

while [ $# -gt 0 ]; do
  awk_counter $1
  shift
done

if [ $sum_result_flag ]; then
  echo $result_columns
fi

exit 0
