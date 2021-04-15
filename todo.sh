#!/bin/bash

help() {
  echo "Please use the following commands in this format:
            ./todo.sh [commands] [options] [...arguments]

        Commands use the following structure:
            list-users [options] [...arguments]
              [options]
                list-users,                 lists all users
                list-todos,                 lists all todos
                list-user-todos [username], list all users and todos,
                                            or specific user's todos
            add [options] [...arguments]
              [options]
                add-user [username],        adds user
                add-todo [username] [todo], adds todo to user
            mark-todos [options] [...arguments]
              [options]
                mark [todo id],             marks todo as done
                unmark [todo id],           marks todo as in progress
            delete [options] [...arguments]
              [options]
                delete-todo [todo id],      deletes specific todo
                delete-done,                deletes all todos with done status
  "
}

main() {
  if [[ "$1" == "list-users" ]]; then
    ./list.sh "$2" "$3"
  elif [[ "$1" == "add" ]]; then
    ./add.sh "$2" "$3" "$4"
  elif [[ "$1" == "mark-todos" ]]; then
    ./mark.sh "$2" "$3"
  elif [[ "$1" == "delete" ]]; then
    ./delete.sh "$2" "$3"
  elif [[ "$1" == "help" ]]; then
    help
  else
    echo "Please type help for additional info.

              ./todo.sh help"
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
