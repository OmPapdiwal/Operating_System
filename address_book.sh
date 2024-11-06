#!/bin/bash

# Address book file
ADDRESS_BOOK="address_book.txt"

# Function to create an empty address book
create_address_book() {
    > "$ADDRESS_BOOK"
    echo "Address book created successfully."
}

# Function to view the address book
view_address_book() {
    if [[ -s "$ADDRESS_BOOK" ]]; then
        echo "Address Book:"
        cat "$ADDRESS_BOOK"
    else
        echo "Address book is empty."
    fi
}

# Function to insert a record
insert_record() {
    echo "Enter Name:"
    read name
    echo "Enter Phone Number:"
    read phone
    echo "Enter Address:"
    read address
    echo "$name | $phone | $address" >> "$ADDRESS_BOOK"
    echo "Record added successfully."
}

# Function to delete a record
delete_record() {
    echo "Enter the name of the record to delete:"
    read name
    if grep -q "^$name" "$ADDRESS_BOOK"; then
        grep -v "^$name" "$ADDRESS_BOOK" > temp && mv temp "$ADDRESS_BOOK"
        echo "Record deleted successfully."
    else
        echo "Record not found."
    fi
}

# Function to modify a record
modify_record() {
    echo "Enter the name of the record to modify:"
    read name
    if grep -q "^$name" "$ADDRESS_BOOK"; then
        delete_record "$name"
        echo "Enter new Phone Number:"
        read phone
        echo "Enter new Address:"
        read address
        echo "$name | $phone | $address" >> "$ADDRESS_BOOK"
        echo "Record modified successfully."
    else
        echo "Record not found."
    fi
}

# Function to search for a record
search_record() {
    echo "Enter the name of the record to search for:"
    read name
    if grep -q "^$name" "$ADDRESS_BOOK"; then
        echo "Record found:"
        grep "^$name" "$ADDRESS_BOOK"
    else
        echo "Record not found."
    fi
}

# Main menu
while true; do
    echo "Choose an option:"
    echo "a) Create address book"
    echo "b) View address book"
    echo "c) Insert a record"
    echo "d) Delete a record"
    echo "e) Modify a record"
    echo "f) Search for a record"
    echo "g) Exit"
    read choice

    case $choice in
        a) create_address_book ;;
        b) view_address_book ;;
        c) insert_record ;;
        d) delete_record ;;
        e) modify_record ;;
        f) search_record ;;
        g) echo "Exiting." ; exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac
done

