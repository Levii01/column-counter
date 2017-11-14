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

if [ $# -eq 0 ]; then
  if [ $sum_result_flag ] ; then
    awk '{for(i=1;i<=NF;i++){sum[i]+=$i}} END {for(i=1;i<=NF;i++){print wyn+=sum[i]} print wyn}' $file
    # sumowanie kazdej liczby w kolumnie, kolejna petla tworzy wynikowa kolumne liczb i ja wypisuje, sumuje i wyswietla jej wartosc.
    exit 0
  fi

  awk '{for(i=1;i<=NF;i++){sum[i]+=$i}} END {for(i=1;i<=NF;i++){print sum[i]}}' $file
  exit 0
fi

while [ $# -gt 0 ]; do
  sum_column=`awk -v x=$1 '{y+=$x} END {print y}' $file`
  # sumowanie kolumny do jednej zmiennej
  echo $sum_column

  if [ $sum_result_flag ]; then
  	let result_columns+=$sum_column
  fi
  shift
done

if [ $sum_result_flag ]; then
  echo $result_columns
fi
