PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INPUT=$1

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #check for atomic_number by checking if the input is number
  if [[ $INPUT =~ ^[0-9]+$ ]]
  then
  ATOMIC_NUMBER=$INPUT
  DATA=$($PSQL "SELECT * FROM properties INNER JOIN types USING (type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER;")
    if [[ -z $DATA ]]
    then
      #if there's not a entry with that atomic number
      echo "I could not find that element in the database."
    else
      #if there's a entry with that atomic number
      echo "$DATA" | while read ATOMIC_NUM BAR TYPE_ID BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE BAR SYMBOL BAR NAME
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
      #The element with atomic number $ATOMIC_NUMBER is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
    fi
  else
    #if $SYMBOL is not a number
    LENGTH=$(echo -n "$INPUT" | wc -m)
    if [[ $LENGTH -le 2 ]]
    then
      SYMBOL=$INPUT
      DATA=$($PSQL "SELECT * FROM properties INNER JOIN types USING (type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$SYMBOL';")
      if [[ -z $DATA ]]
      then
      #if there's not a entry with that symbol
      echo "I could not find that element in the database."
      else
      #if there's a entry with that symbol
      echo "$DATA" | while read ATOMIC_NUM BAR TYPE_ID BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE BAR SYMBOL BAR NAME
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
      fi

    else
      NAME=$INPUT
      DATA=$($PSQL "SELECT * FROM properties INNER JOIN types USING (type_id) INNER JOIN elements USING(atomic_number) WHERE name='$NAME';")
      if [[ -z $DATA ]]
      then
      #if there's not a entry with that name
      echo "I could not find that element in the database."
      else
      #if there's a entry with that name
      echo "$DATA" | while read ATOMIC_NUM BAR TYPE_ID BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE BAR SYMBOL BAR NAME
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
      fi
    fi
  fi
fi

