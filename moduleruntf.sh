cat main.tf | grep 'module "*' | tr -d ' {' | sed  's/module"/module./' | tr -d '"'| while read line
do
    if [[ ! "$1" = "" ]]; then
        if [[ "$1" = "apply" ]]; then
            terraform $1 -target=$(echo $line | tr -d " ") -auto-approve
        else
            echo "$1 neither apply or destroy"
            exit 1
        fi
    fi
done