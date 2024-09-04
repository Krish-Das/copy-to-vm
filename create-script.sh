#!/bin/bash

# Ask the user for the name of the script
echo "Enter the name of the script (without the .sh extension):"
read -r script_name

# Define the directories
config_dir="$HOME/.config/scripts"
bin_dir="$HOME/.local/bin"

# Create the directories if they don't exist
mkdir -p "$config_dir"
mkdir -p "$bin_dir"

# Create the script file
script_file="$config_dir/$script_name.sh"
touch "$script_file"

# Create the symlink
ln -s "$script_file" "$bin_dir/$script_name"

# Print a message
echo "Script $script_name.sh created in $config_dir and symlinked to $bin_dir"