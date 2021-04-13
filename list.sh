#!/bin/bash
#
# list.sh list-users
# list.sh list-todos
# list.sh list-user-todos
#
# Usage:
#    list.sh list-users
#    list.sh list-todos Paul
#    list.sh list-user-todos John
#    list.sh list-user-todos "John Doe"
#

DATABASE="tododb"
export PGPASSWORD=${PSQL_PASSWORD}

list_users() {
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
SELECT * FROM "user"
EOF
}

list_todos() {
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
    SELECT task FROM "todo"
EOF
}

list_user_todos() {
  user=$1
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
    SELECT name, task, todo_id FROM "todo" JOIN "user" u on u.user_id = todo.user_id
    WHERE name ILIKE '$user%'
EOF
}

main() {
    if [[ "$#" -eq 0 ]]
    then
      echo "Missing arguments:
            list.sh [arguments] [username]
            - list-todos
            - list-user
            - list-user-todo [username]"
    elif [[ "$1" == "list-users" ]]
    then
        list_users
    elif [[ "$1" == "list-todos" ]]
    then
        list_todos
    elif [[ "$1" == "list-user-todos" ]]
    then
        list_user_todos "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
