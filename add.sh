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

DATABASE="tododb"
export PGPASSWORD=${PSQL_PASSWORD}

add_user() {
  username=$1
    psql -h "${PSQL_HOST}" -U "${PSQL_USER_NAME}" $DATABASE <<EOF
INSERT INTO "user" (name) VALUES ('$username')
EOF
    echo "user added: $username"
}

add_todo() {
    username=$1
    todo=$2
    psql -h "${PSQL_HOST}" -U "${PSQL_USER_NAME}" $DATABASE -v ON_ERROR_STOP=1 2> /dev/null <<EOF
INSERT INTO "todo" (user_id, task, done) VALUES
((SELECT user_id FROM "user" WHERE name='$username'), '$todo', false)
EOF
  if [[ "$?" -eq 3 ]]; then
    echo "No user named $username found. Please add user first with ./add.sh add-user [username] before adding todos."
  else
    echo "$todo added to user $username"
  fi
}

main() {
    if [[ "$#" -lt 2 ]]
    then
      echo "Missing arguments:
            add.sh [arguments] [username] [todo]
            - add-user [username]
            - add-todo [username] [todo]"
    elif [[ "$1" == "add-user" ]]
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
