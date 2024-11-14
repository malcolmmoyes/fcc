#!/bin/bash

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
  exit
fi

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --csv -c"
BASE_QUERY="select
  e.atomic_number,
  e.name,
  e.symbol,
  t.type,
  p.atomic_mass,
  p.melting_point_celsius,
  p.boiling_point_celsius
  from elements e
  join properties p using(atomic_number)
  join types t using(type_id)"


if [[ $1 -ge 1 ]]
then
  RESULT=`$PSQL "$BASE_QUERY where e.atomic_number = $1"`
elif [[ ${#1} -le 2 ]]
then
  RESULT=`$PSQL "$BASE_QUERY where e.symbol = '$1'"`
else
  RESULT=`$PSQL "$BASE_QUERY where e.name = '$1'"`
fi

if [[ -z $RESULT ]]
then
  echo "I could not find that element in the database."
else
  IFS="," read NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<<$RESULT
  
  echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
fi
