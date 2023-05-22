#! /bin/bash

# This script can search for information on elements in the periodic table.
# When run correctly, it returns atomic number, name, symbol, boiling point in C, melting point in C,
# and whether it's a metal, nonmetal, or metalloid
# The script is currently limited to the first ten elements in the periodic table.

# Use this variable to invoke postgreSQL and make queries to the database
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# Check to see if an argument was passed
if [[ $1 ]]; then
  # Query the database for the requested element
  # We need to join elements, properties, and types to get all of the information we need
  DESIRED_COLUMNS="atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius"
  SELECT_JOIN="SELECT $DESIRED_COLUMNS FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id)"
  # We also need to figure out what the user is searching for, which requires us to check input type
  # If the script argument is just numbers we can just check atomic number
  if [[ $1 =~ ^[0-9]+$ ]]; then
    CONDITION="WHERE atomic_number = $1"
    # If it's not—if the argument consists of letters—we search symbol or name
  else
    CONDITION="WHERE symbol ILIKE '$1' OR name ILIKE '$1'"
  fi
  ELEMENT_INFO=$($PSQL "$SELECT_JOIN $CONDITION")

  # If the query returns a null value, tell the user they blew it
  if [[ -z $ELEMENT_INFO ]]; then
    echo "I could not find that element in the database."
    # Otherwise, if something is found, break it down into component variables
    else
      # We can break down the query result into variables and stick them into the output message
      IFS=" | " read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_WEIGHT MELT_POINT BOIL_POINT <<< $ELEMENT_INFO
      FORMATTED_OUTPUT="The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_WEIGHT amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
      echo $FORMATTED_OUTPUT
  fi # end if $ELEMENT_INFO is not empty
# If no argument was passed to the script, ask the user to run it again with one
else
  echo "Please provide an element as an argument."
fi # end if first argument $1 is not empty
