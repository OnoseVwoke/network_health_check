#!/bin/bash

TODO_FILE=~/todo.txt

touch $TODO_FILE

while true
do
    echo "=========================="
    echo "      TO-DO MANAGER"
    echo "=========================="
    echo "1. View all tasks"
    echo "2. Add a new task"
    echo "3. Delete a task"
    echo "4. Exit"

    read -p "Choose an option: " choice

    case $choice in

        1)
            echo "------ TASKS ------"

            if [ ! -s $TODO_FILE ]; then
                echo "No tasks available."
            else
                nl -w2 -s'. ' $TODO_FILE
            fi
            ;;

        2)
            read -p "Enter new task: " task
            echo "$task" >> $TODO_FILE
            echo "Task added successfully."
            ;;

        3)
            echo "------ TASKS ------"

            if [ ! -s $TODO_FILE ]; then
                echo "No tasks to delete."
            else
                nl -w2 -s'. ' $TODO_FILE

                read -p "Enter task number to delete: " task_number

                sed -i "${task_number}d" $TODO_FILE

                echo "Task deleted successfully."
            fi
            ;;

        4)
            echo "Exiting program..."
            break
            ;;

        *)
            echo "Invalid choice."
            ;;
    esac

    echo ""
done
