#!/bin/bash
#
# add.sh add-user <user>
# add.sh add-todo <user> <todo>
#
# Usage:
#    add.sh add-user John
#    add.sh add-user Paul
#    add.sh add-todo John Meeting
#    add.sh add-todo Paul "Make breakfast"
#

DATABASE="todo-test"
export PGPASSWORD=${PSQL_PASSWORD}

add_user() {
  username=$1
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
INSERT INTO "user" (name) VALUES ('$username')
EOF
    echo "user added: $username"
}

add_todo() {
    username=$1
    todo=$2
    psql -h ${PSQL_HOST} -U ${PSQL_USER_NAME} $DATABASE <<EOF
INSERT INTO "user" (name) VALUES ('$username')
EOF

}

main() {
    if [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
