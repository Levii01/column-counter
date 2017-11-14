#!/usr/bin/env bash

function error_with {
  echo "$1"
  exit 1
}

function script_name {
  basename "$0"
}

function syntax_error {
  echo "Błąd składni"
}

function variable_error {
  echo "Użycie niepoprawnego argumentu"
}

function access_error {
  echo "Brak odpowiednich praw dostępu"
}


# Start
if [[ "$#" = 0 ]]; then
  error_with 'Nie podałeś żadnej zmiennej do skryptu \nspróbuj `script.sh  plik.txt  3 5`'
fi

if [[ "$1" = '-a' ]]; then
  sum_result=true
  shift
fi

if [ $sum_result ] ; then
  echo "z parametrem -a"
fi

echo "Uruchomiłeś program `basename $0`"
echo Wszystkie parametry: $@

# przypisanie pliku
file=$1
echo Plik z którego odczytam wartości: $file
shift

columns=$@
echo Kolumny które zsumuje: ${columns}

# script_name
# syntax_error
# variable_error
# access_error
