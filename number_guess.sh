#! /bin/bash

echo -e "\n~~~~~ Let's Play Number-Guessing Game ~~~~~"

# Prompt the player for their username
echo -e "\nEnter your username:"
read USERNAME

# Search database for user info #

# This variable is used to make queries to the database
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

FIND_USER_QUERY="SELECT num_times_played, best_game FROM users WHERE username = '$USERNAME'"
USER_RESULT=$($PSQL "$FIND_USER_QUERY")
NUM_TIMES_PLAYED=0
BEST_GAME=1000000

# If the username is in the database, print a message welcoming them back
if [[ $USER_RESULT ]]; then
  IFS="|" read NUM_TIMES_PLAYED BEST_GAME <<< $USER_RESULT
  echo "Welcome back, $USERNAME! You have played $NUM_TIMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  # If the username is new, add them to the database and welcome them to the game
  ADD_USER_QUERY="INSERT INTO users(username) VALUES('$USERNAME')"
  INSERT_RESULT=$($PSQL "$ADD_USER_QUERY")
  if [[ $INSERT_RESULT == "INSERT 0 1" ]]; then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  fi
fi

# Generate a random number between 1 and 1000
SECRET_NUMBER=$[ $RANDOM % 1000  + 1]

# Start the guessing loop #

# Ask the player for their guess
echo -e "\nGuess the secret number between 1 and 1000:"

# Start tracking number of guesses
NUM_GUESSES=0
while [[ $NEXT_GUESS != $SECRET_NUMBER ]]
do
  # Get the guess here
  read NEXT_GUESS
  ((NUM_GUESSES++))
  # Check to make sure the guess is an integer
  if [[ $NEXT_GUESS =~ ^[0-9]+$ ]]; then
    # Now, check answers
    # If they're wrong, tell them if they're high or low
    if [[ $NEXT_GUESS > $SECRET_NUMBER ]]; then
      echo -e "\nIt's lower than that, guess again:"
    elif [[ $NEXT_GUESS < $SECRET_NUMBER ]]; then
      echo -e "\nIt's higher than that, guess again:"
    else
      # If it's correct, say so and record the win in the database and how many guesses were made
      echo -e "\nYou guessed it in $NUM_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      # Increment number of wins
      ((NUM_TIMES_PLAYED++))
      # Compare this win to the best record to see if the player outdid themselves
      if (( $NUM_GUESSES < $BEST_GAME )); then
        BEST_GAME=$NUM_GUESSES
      fi
      # Update the database
      UPDATE_QUERY="UPDATE users SET num_times_played = $NUM_TIMES_PLAYED, best_game = $BEST_GAME WHERE username = '$USERNAME'"
      UPDATE_RESULT=$($PSQL "$UPDATE_QUERY")
    fi # end if guess is high or low or correct
  else
    echo -e "\nThat is not an integer, guess again:"
  fi # end if guess is an integer
done
