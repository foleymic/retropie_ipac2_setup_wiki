#!/bin/bash

# Define the source and destination directories
SOURCE_DIR="$1"
DEST_DIR="$2"

# Check if both directories are provided
if [ -z "$SOURCE_DIR" ] ; then
  echo "Source directory not specified.  Will use default - './files/retropie_controller_configurations/configs'"
  SOURCE_DIR="./files/retropie_controller_configurations/configs"
fi

if [ -z "$DEST_DIR" ] ; then
  echo "Destination directory not specified.  Will use default - '/opt/retropie/configs'"
  DEST_DIR="/opt/retropie/configs"
fi

echo "Source directory: ${SOURCE_DIR}"
echo "Destination directory: ${DEST_DIR}"


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

# Find all files (not directories) under the source directory
find "$SOURCE_DIR" -type f | while read -r FILE; do
  # Get the relative path of the file inside the source directory
  RELATIVE_PATH="${FILE#$SOURCE_DIR/}"
  echo "RELATIVE_PATH: ${RELATIVE_PATH}"

exit

  # Define the destination file path
  DEST_FILE="$DEST_DIR/$RELATIVE_PATH"

  # Ensure the destination subdirectory exists
  DEST_SUBDIR=$(dirname "$DEST_FILE")
  if [ ! -d "$DEST_SUBDIR" ]; then
    echo "Creating directory $DEST_SUBDIR"
    mkdir -p "$DEST_SUBDIR"
  fi

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
done

echo "Files copied successfully!"
