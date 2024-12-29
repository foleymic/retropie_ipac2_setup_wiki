#!/bin/bash

# Define the source and destination directories
SOURCE_DIR="$1"
DEST_DIR="$2"

# Check if both directories are provided
if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory $SOURCE_DIR does not exist!"
  exit 1
fi

# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
  echo "Destination directory $DEST_DIR does not exist, creating it..."
  mkdir -p "$DEST_DIR"
fi

# Loop through all files in the source directory
for FILE in "$SOURCE_DIR"/*; do
  # Check if it's a regular file
  if [ -f "$FILE" ]; then
    # Get the filename
    FILENAME=$(basename "$FILE")
    DEST_FILE="$DEST_DIR/$FILENAME"

    # Check if the destination file exists
    if [ -e "$DEST_FILE" ]; then
      # Backup the destination file
      BACKUP_FILE="$DEST_FILE.bak"
      echo "Backing up $DEST_FILE to $BACKUP_FILE"
      mv "$DEST_FILE" "$BACKUP_FILE"
    fi

    # Copy the file from source to destination
    echo "Copying $FILE to $DEST_FILE"
    cp "$FILE" "$DEST_FILE"
  fi
done

echo "Files copied successfully!"
