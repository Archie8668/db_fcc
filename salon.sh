#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Scheduler ~~~~~\n"

MAIN_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi

    # Show services the salon offers
    echo -e "How may I help you?\n"
    SERVICES_OFFERED=$($PSQL "SELECT service_id, name FROM services")
    echo "$SERVICES_OFFERED" | while read SERVICE_ID BAR SERVICE_NAME
    do
        echo "$SERVICE_ID) $SERVICE_NAME"
    done
    read SERVICE_ID_SELECTED
    
    CHOSEN_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    # if the service doesn't exist
    if [[ -z $CHOSEN_SERVICE_NAME ]]
    then
        MAIN_MENU "No such service"
    else
        # get customer phone number
        echo -e "\nWhat is the customer's phone number?"
        read CUSTOMER_PHONE

        # get customer's name based on phone number
        CUSTOMER_NAME=$($PSQL "SELECT name from customers WHERE phone = '$CUSTOMER_PHONE'")
        # if number is not in the database
        if [[ -z $CUSTOMER_NAME ]]
        then
            # add the customer
            echo -e "\nWhat is the customer's name?"
            read CUSTOMER_NAME
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
        fi
        # get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        echo -e "What is the appointment time?"
        read SERVICE_TIME
        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
        if [[ $INSERT_APPOINTMENT_RESULT == "INSERT 0 1" ]]
        then
        FORMATTED_SERVICE_NAME=$(echo $CHOSEN_SERVICE_NAME | sed 's/ //')
        FORMATTED_CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed 's/ //')
            echo -e "\nI have put you down for a $FORMATTED_SERVICE_NAME at $SERVICE_TIME, $FORMATTED_CUSTOMER_NAME."
        fi
    fi
}

MAIN_MENU