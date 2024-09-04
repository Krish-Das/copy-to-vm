#!/bin/bash

# Array of folders to create
folders=("Downloads" "Pictures" "Videos" "Musics" "Documents")

# Loop through each folder
for folder in "${folders[@]}"
do
    # If the folder does not exist
    if [ ! -d "$HOME/$folder" ]
    then
        # Print a message and create the folder
        echo "Creating $folder folder"
        mkdir "$HOME/$folder"
    else
        # If the folder exists, ask the user what to do
        echo "$folder folder already exists. Do you want to keep it or remove it? (k/r)"
        read -r -n 1 -s answer
        echo
        if [ "$answer" = "r" ]
        then
            # Remove the folder
            echo "Removing $folder folder"
            rm -r "$HOME/$folder"
            # Print a message and create the folder
            echo "Creating $folder folder"
            mkdir "$HOME/$folder"
        else
            # Keep the folder
            echo "Keeping $folder folder"
        fi
    fi
done
