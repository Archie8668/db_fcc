#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clear the tables to ensure there's no lingering data that will mess up this process
echo $($PSQL "TRUNCATE games, teams")

# To insert this data, we read games.csv, which lists World Cup round winners
# Data is, in order: year, round, winner, opponent, winner_goals, opponent_goals
# winner and opponent are names which need to be inserted into teams
# The rest can be inserted into games, with winner and opponent referencing team_ids
# As the script peruses the data, it needs to add teams that aren't in the teams table

# Make an associative array to hold team names and IDs for later use
# Caching them saves us from making a load of database queries
declare -A TEAM_ARRAY

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Make sure we're not reading the first line, with the headings. That's not real data.
  if [[ $YEAR != "year" ]]
  then
    # Check the team info cache to see if they're in the database
    TEAM1_ID=${TEAM_ARRAY[$WINNER]}
    if [[ -z $TEAM1_ID ]]
    then
      # If not in the database, insert it
      RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      TEAM_ARRAY+=([$WINNER]=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'"))
    fi
    TEAM2_ID=${TEAM_ARRAY[$OPPONENT]}
    if [[ -z $TEAM2_ID ]]
    then
      # If not in the database, insert it
      RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      TEAM_ARRAY+=([$OPPONENT]=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'"))
    fi
    # End checking for teams in database

    # Now we start entering team info into the games table
    # That's pretty straightforward, for the most part
    # The hard part is knowing what team_ids to insert into the winner_id and opponent_id columns
    # TEAM_ARRAY is a cache for storing IDs so we don't need to query the database more than necessary
    WINNER_ID=${TEAM_ARRAY[$WINNER]}
    OPPONENT_ID=${TEAM_ARRAY[$OPPONENT]}
    RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
  # End if not reading header
done
# End do read games.csv
