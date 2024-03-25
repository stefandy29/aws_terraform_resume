src=$2
filename="terraform.tfstate"

if [[ "$1" = "load" ]]; then
    if [[ "$(aws s3 ls $2 | awk '{print $4}' | tr -d " \n")" = "$filename" ]]; then
        aws s3 cp "s3://$2/$filename" $filename
    else
        echo "$filename not found"
    fi
elif [[ "$1" = "save" ]]; then
    aws s3 cp $filename "s3://$2"
else
    echo "$1 neither load or save"
fi