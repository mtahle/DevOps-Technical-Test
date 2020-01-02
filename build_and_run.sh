#!/bin/bash
build_image() {

   docker build -t "$IMAGE:$TAG" .

}

run_container(){
# check if there is already running container with the name "web" and prompt user what to do
    RUNNING_CONTAINERS_NAMES=()
    while IFS= read -r line; do
        RUNNING_CONTAINERS_NAMES+=( "$line" )
    done < <( docker ps --format '{{.Names}}' -a)

    for CONTAINER_NAME in "${RUNNING_CONTAINERS_NAMES[@]}"
    do
        if [ "$CONTAINER_NAME" != "web" ];then
        docker run -d -p80:80 --name web $IMAGE:$TAG
        else
            echo "There is a currently running container with the name $CONTAINER_NAME has the value"
            read -p "Do you want to stop and remove it? (Y/N)" ANSWER
            if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]; then
                docker rm -f $CONTAINER_NAME
                docker run -d -p80:80 --name web $IMAGE:$TAG
                break

            elif [ "$ANSWER" = "N" ] || [ "$ANSWER" = "n" ]; then
                exit 0
            else 
                read -p "Do you want to stop and remove it? (Y/N)" ANSWER
            fi
        fi
    done

}

test_connection(){
    curl localhost:80/data.json
}
IMAGE="$1"
TAG="$2"

build_image $IMAGE $TAG
run_container $IMAGE $TAG
test_connection
