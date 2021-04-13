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
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
DELETE FROM "todo" WHERE todo_id=$todo_id
EOF
    echo "Todo removed"
}

delete_done() {
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
DELETE FROM "todo" WHERE done=TRUE
EOF
    echo "Done todos removed"
}

main() {
    if [[ "$#" -lt 1 ]]
    then
      echo "Missing arguments:
            delet.sh [arguments]
            - delete-todo [todo_id]
            - delete-done"
    elif [ "$#" -gt 0 ] && [ "$#" -lt 2 ];
    then
      echo "Missing argument:
            - delete-todo [todo_id]"
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
