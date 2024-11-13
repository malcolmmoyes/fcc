#!/bin/bash

PSQL="psql -t --csv --username=freecodecamp --dbname=salon -c"

display_services() {
  if [[ -n $1 ]]
  then
    echo -e "$1\n"
  fi

  $PSQL "select * from services" | sed 's/,/) /'

  echo -e "\nWhich service is required?"
  get_service_id
}

get_service_id() {
  read SERVICE_ID_SELECTED

  $PSQL "select service_id from services" | grep -q ^$SERVICE_ID_SELECTED$

  if [[ $? == 0 ]]
  then
    check_customer
  else
    display_services "$SERVICE_ID_SELECTED is not listed."
  fi
}

check_customer() {
  echo -e "\nPlease enter your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_ID=`$PSQL "select customer_id from customers where phone = '$CUSTOMER_PHONE'"`
  if [[ -n $CUSTOMER_ID ]]
  then
    echo
  else
    create_customer $CUSTOMER_PHONE
  fi
}

create_customer() {
  echo -e "\nYou're new here. What's your name?"
  read CUSTOMER_NAME
  $PSQL "insert into customers(phone, name) values('$1', '$CUSTOMER_NAME')" > /dev/null
  CUSTOMER_ID=`$PSQL "select customer_id from customers where phone = '$1'"`
  echo booking appointment for $CUSTOMER_ID
}


display_services "Which service is required?"

echo -e "\nWhen would you like your appointment?"
read SERVICE_TIME
$PSQL "insert into appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')" > /dev/null
CONFORMATION=`$PSQL "select s.name, c.name, time from appointments a join customers c using(customer_id) join services s using(service_id) where customer_id=$CUSTOMER_ID and service_id=$SERVICE_ID_SELECTED and time='$SERVICE_TIME'"`
echo -e "\nI have put you down for a `echo $CONFORMATION | cut -d, -f1` at `echo $CONFORMATION | cut -d, -f3`, `echo $CONFORMATION | cut -d, -f2`."

