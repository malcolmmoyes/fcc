#!/bin/bash

TARGET=$(($RANDOM % 1000 + 1))
ATTEMPTS=1

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME

IS_USERNAME=`$PSQL "select true from users where username = '$USERNAME'"`
if [[ $IS_USERNAME ]]
then
  IFS="|" read BEST_GAME GAMES_PLAYED <<< `$PSQL "select best_game, games_played from users where username='$USERNAME'"`
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  $PSQL "update users set games_played = games_played + 1 where username='$USERNAME'" > /dev/null
else
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "insert into users(username, games_played) values('$USERNAME', 1)" > /dev/null
  BEST_GAME=0
fi

echo "Guess the secret number between 1 and 1000:"
echo $TARGET
read GUESS

while [[ $TARGET != $GUESS ]]
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  elif [[ $GUESS -gt $TARGET ]]
  then
    echo "It's lower than that, guess again:"
    ((ATTEMPTS++))
  elif [[ $GUESS -lt $TARGET ]]
  then
    echo "It's higher than that, guess again:"
    ((ATTEMPTS++))
  fi
  read GUESS
done

echo "You guessed it in $ATTEMPTS tries. The secret number was $TARGET. Nice job!"

if [[ $ATTEMPTS -lt $BEST_GAME || $BEST_GAME = 0 ]]
then
  $PSQL "update users set best_game=$ATTEMPTS where username='$USERNAME'" > /dev/null
fi
