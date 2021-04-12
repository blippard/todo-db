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

DATABASE="todo-test"
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
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
    SELECT name, task FROM "todo" JOIN "user" u on u.user_id = todo.user_id
EOF
}

main() {
    if [[ "$1" == "list-users" ]]
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
