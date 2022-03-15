#!/bin/sh

# This shell script works if you run only one container on your local.  

CONTAINER_NAME="static-cats-website"

if [ -z "$1" ]
then
    echo "\nOops! Please provide image tag(version).\nEg: v1.0.0, v1.0.1, or v1.0.2\n"
else
    NEW_VERSION="$1"

    LATEST_IMAGE_NAME=$CONTAINER_NAME:latest
    NEW_IMAGE_NAME=$CONTAINER_NAME:$NEW_VERSION
    
    echo "\n"
    echo "1. We are gonna build the docker images:" 
    echo a. $LATEST_IMAGE_NAME
    echo b. $NEW_IMAGE_NAME

    echo "\n"
    echo 2. Stop container $CONTAINER_NAME
    echo Running... "'docker stop $CONTAINER_NAME'"
    docker stop $CONTAINER_NAME

    echo "\n"
    echo 3. Remove container $CONTAINER_NAME
    echo Running... "'docker rm $CONTAINER_NAME'"
    docker rm $CONTAINER_NAME

    echo "\n"
    echo 4. Remove $LATEST_IMAGE_NAME image from local
    echo Running... "'docker image rm $LATEST_IMAGE_NAME'"
    docker image rm $LATEST_IMAGE_NAME

    echo "\n"
    echo 5. Remove $NEW_IMAGE_NAME image from local
    echo Running... "'docker image rm $NEW_IMAGE_NAME'"
    docker image rm $NEW_IMAGE_NAME

    echo "\n"
    echo 6. Build $LATEST_IMAGE_NAME image
    echo Running... "'docker build -t $LATEST_IMAGE_NAME .'"
    docker build -t $LATEST_IMAGE_NAME .

    echo "\n"
    echo 7. Duplicate $LATEST_IMAGE_NAME to $NEW_IMAGE_NAME
    echo Running... "'docker tag $LATEST_IMAGE_NAME $NEW_IMAGE_NAME'"
    docker tag $LATEST_IMAGE_NAME $NEW_IMAGE_NAME

    echo "\n"
    echo 8. Start $CONTAINER_NAME container from $NEW_IMAGE_NAME
    echo Running... "'docker run --name $CONTAINER_NAME -d -p 8080:80 $NEW_IMAGE_NAME'"
    docker run --name $CONTAINER_NAME -d -p 8080:80 $NEW_IMAGE_NAME

    echo "\n"
    echo 9. Show all available image versions of $CONTAINER_NAME:
    echo "\n"
    echo Running... "'docker images --filter "reference=$CONTAINER_NAME"'"
    echo "\n"
    docker images --filter "reference=$CONTAINER_NAME"
    
    echo "\n"
    echo 10. Server started on: http://localhost:8080/
    echo "\n"

fi