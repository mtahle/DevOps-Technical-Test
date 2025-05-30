#!/bin/bash
build_image() {

   docker build -t "$IMAGE:$TAG" .

}

run_container(){
    # ensure only a single container called "web" exists
    if docker ps --format '{{.Names}}' -a | grep -wq "web"; then
        echo "There is a currently running container with the name web"
        read -p "Do you want to stop and remove it? (Y/N) " ANSWER
        if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]; then
            docker rm -f web
        else
            exit 0
        fi
    fi

    docker run -d -p80:80 --name web "$IMAGE:$TAG"
}

test_connection(){
    curl localhost:80/data.json
}
IMAGE="$1"
TAG="$2"

build_image $IMAGE $TAG
run_container $IMAGE $TAG
test_connection
