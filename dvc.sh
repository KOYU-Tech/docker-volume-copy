#!/bin/bash
# Koyu.Tech @adamasantares

if (( $# < 2 )); then
    echo ""
    echo "No arguments provided"
    echo "Use command example:"
    echo "docker-cv.sh OLD_VOLUME_NAME NEW_VOLUME_NAME"
    echo ""
    exit 1
fi

OLD_VOLUME_NAME="$1"
NEW_VOLUME_NAME="$2"

echo "== From '$OLD_VOLUME_NAME' to '$NEW_VOLUME_NAME' =="

function isVolumeExists {
    local isOldExists=$(docker volume inspect "$1" 2>/dev/null | grep '"Name":')
    local isOldExists=${isOldExists#*'"Name": "'}
    local isOldExists=${isOldExists%'",'}
    local isOldExists=${isOldExists##*( )}
    if [[ "$isOldExists" == "$1" ]]; then
        return 1
    else
        return 0
    fi
}


# check if old volume exists
isVolumeExists ${OLD_VOLUME_NAME}
if [[ "$?" -eq 0 ]]; then
    echo "Volume $OLD_VOLUME_NAME doesn't exist"
    exit 2
fi

# check if new volume exists
isVolumeExists ${NEW_VOLUME_NAME}
if [[ "$?" -eq 0 ]]; then
    echo "creating '$NEW_VOLUME_NAME' ..."
    docker volume create ${NEW_VOLUME_NAME} 2>/dev/null 1>/dev/null
    isVolumeExists ${NEW_VOLUME_NAME}
    if [[ "$?" -eq 0 ]]; then
        echo "Cannot create new volume"
        exit 3
    else
        echo "OK"
    fi
fi

# most important part, data migration
docker run --rm --volume ${OLD_VOLUME_NAME}:/source --volume ${NEW_VOLUME_NAME}:/destination ubuntu:latest bash -c "echo 'copying volume ...'; cp -Rp /source/* /destination/"

if [[ "$?" -eq 0 ]]; then
    echo "Done successfuly 🎉"
else
    echo "Some error occured 😭"
fi
