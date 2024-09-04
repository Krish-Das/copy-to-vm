#!/bin/bash

# Define Script name
ccs_name="create-script"

# Define the directories
config_dir="$HOME/.config/scripts"
bin_dir="$HOME/.local/bin"

# Check if the create argument was passed
if [ "$1" = "create" ]
then
    # Ask the user for the name of the script
    echo -e "\e[1mEnter the name of the script\e[0m (without the .sh extension):"
    read -r script_name

    # Create the directories if they don't exist
    mkdir -p "$config_dir"
    mkdir -p "$bin_dir"

    # Create the script file
    script_file="$config_dir/$script_name.sh"
    touch "$script_file"

    # Give the script file executable permissions
    chmod +x "$script_file"

    # Create the symlink
    ln -s "$script_file" "$bin_dir/$script_name"

    # Print a message
    echo -e "\e[32mScript $script_name.sh created in $config_dir and symlinked to $bin_dir\e[0m"
    echo "You can edit the $script_file"
    echo -e "\e[33;1mWarning: Deleting or renaming any files in the $config_dir or $bin_dir may cause broken symlinks.\e[0m\n"
    echo -e "To fix any broken symlinks, please run '$ccs_name sync'."
    
# Check if the sync argument was passed
elif [ "$1" = "sync" ]
then
    # Loop through each file in the config directory
    for file in "$config_dir"/*.sh
    do
        # Get the base name of the file
        base_name=$(basename "$file")
        # Get the name of the file without the extension
        name="${base_name%.*}"

        # If the symlink doesn't exist in the bin directory
        if [ ! -L "$bin_dir/$name" ]
        then
            # Create the symlink
            ln -s "$file" "$bin_dir/$name"
            echo "Created symlink: $bin_dir/$name"
        fi
    done

    # Loop through each file in the bin directory
    for file in "$bin_dir"/*
    do
        # If the file is a symlink and it doesn't point to anything
        if [ -L "$file" ] && [ ! -e "$file" ]
        then
            # Remove the symlink
            rm "$file"
            echo "Removed dead symlink: $file"
        fi
    done
else
    # Print an error message
    echo -e "\e[1;31mInvalid argument.\n\e[0mPlease use 'create' or 'sync'."
fi
