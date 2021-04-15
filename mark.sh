#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#

DATABASE="tododb"
export PGPASSWORD=${PSQL_PASSWORD}

mark() {
  todo_id=$1
  psql -h "${PSQL_HOST}" -U "${PSQL_USER_NAME}" $DATABASE  -v ON_ERROR_STOP=1 2> /dev/null <<EOF
  UPDATE "todo" SET "done" = TRUE WHERE "todo_id" = $todo_id
EOF
  todo_task=$(psql -X -A -d $DATABASE -U "${PSQL_USER_NAME}" -h localhost -p 5432 -t -c "SELECT task FROM "todo" WHERE "todo_id"=$todo_id")

  if [[ "$?" -eq 3 ]]; then
    echo "No todo found with ID $todo_id"
  else
    echo "echo TODO: $todo_task - Marked as done"
  fi
}

unmark() {
  todo_id=$1
  psql -h "${PSQL_HOST}" -U "${PSQL_USER_NAME}" $DATABASE  -v ON_ERROR_STOP=1 2> /dev/null <<EOF
  UPDATE "todo" SET "done" = FALSE WHERE "todo_id" = $todo_id
EOF
  todo_task=$(psql -X -A -d $DATABASE -U ${PSQL_USER_NAME} -h localhost -p 5432 -t -c "SELECT task FROM "todo" WHERE "todo_id"=$todo_id")

  if [[ "$?" -eq 3 ]]; then
    echo "No todo found with ID $todo_id"
  else
    echo "TODO: $todo_task - Marked as *not* done"
  fi
}

main() {
    if [[ "$#" -lt 2 ]]
    then
      echo "Missing arguments:
            mark.sh [arguments] [todo_id]
            - mark [todo_id]
            - unmark [todo_id]"
    elif [[ "$1" == "mark" ]]
    then
        mark "$2"
    elif [[ "$1" == "unmark" ]]
    then
        unmark "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
