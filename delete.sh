#!/bin/bash
#
# delete.sh delete-todo <todo-id>
# delete.sh delete-done
#
# Usage:
#    delete.sh delete-todo 99
#    delete.sh delete-done
#

#echo "Your code"

DATABASE="tododb"
export PGPASSWORD=${PSQL_PASSWORD}

delete_todo() {
  todo_id="$1"
    psql -h "${PSQL_HOST}" -U "${PSQL_USER_NAME}" $DATABASE  -v ON_ERROR_STOP=1 2> /dev/null <<EOF
DELETE FROM "todo" WHERE todo_id=$todo_id
EOF

  if [[ "$?" -eq 3 ]]; then
    echo "No todo found with ID: $todo_id"
  else
    echo "Todo removed"
  fi
}

delete_done() {
    psql -h "${PSQL_HOST}" -U "${PSQL_USER_NAME}" $DATABASE  -v ON_ERROR_STOP=1 2> /dev/null <<EOF
DELETE FROM "todo" WHERE done=TRUE
EOF

  if [[ "$?" -eq 3 ]]; then
    echo "No done status todos found"
  else
    echo "All done status todos removed"
  fi
}

main() {
    if [[ "$#" -lt 1 ]]
    then
      echo "Missing arguments:
            delete.sh [arguments]
            - delete-todo [todo_id]
            - delete-done"
    elif [[ "$1" == "delete-todo" ]]
    then
        delete_todo "$2"
    elif [[ "$1" == "delete-done" ]]
    then
        delete_done
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
