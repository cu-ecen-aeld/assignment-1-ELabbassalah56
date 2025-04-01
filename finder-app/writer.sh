#!/bin/bash
# Author: Elabbas Salah Hatata, Coursera Advanced Embedded Linux

if [ $# -ne 2 ]; then
    #echo "Usage: $0 <file_path> <content_to_write>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Check if the directory exists, create if not
dirpath=$(dirname "$writefile")
if [ ! -d "$dirpath" ]; then
    # echo "Warning: Directory not found. Creating directory..."
    mkdir -p "$dirpath" || { echo "Failed to create directory"; exit 1; }
fi

# Function to show animated ".." increasing & decreasing in place
animate_processing() {
    while true; do
        echo -ne "Processing in directory: $writefile .  \r"
        sleep 0.5
        echo -ne "Processing in directory: $writefile .. \r"
        sleep 0.5
        echo -ne "Processing in directory: $writefile ...\r"
        sleep 0.5
        echo -ne "Processing in directory: $writefile .. \r"
        sleep 0.5
        echo -ne "Processing in directory: $writefile .  \r"
        sleep 0.5
    done
}

# Start the animation in the background
animate_processing &

# Store the animation process ID
ANIM_PID=$!

# Create the file (overwrite if exists)
touch "$writefile"
if [ $? -ne 0 ]; then
    #echo "Failed to create the file!"
    kill $ANIM_PID
    wait $ANIM_PID 2>/dev/null
    exit 1
fi

# Write the content to the file
echo -n "$writestr" > "$writefile"

# Stop the animation
kill $ANIM_PID
wait $ANIM_PID 2>/dev/null

# Print the completion message
date 
echo -e "Write complete! \r"
