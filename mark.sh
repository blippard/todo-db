#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#

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
