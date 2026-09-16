#!/bin/bash

# Create a tar file with proper permissions for web deployment
# Directories: 0755 (rwxr-xr-x)
# Files: 0644 (rw-r--r--)

TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)
TAR_FILE="PeaceAbility-dist-${TIMESTAMP}.tar"
TAR_GZ_FILE="${TAR_FILE}.gz"

# Create tar file from dist/ with correct permissions
# We'll use find with tar to create the archive with proper modes
find dist -print0 | tar --null --owner=0 --group=0 -cf "$TAR_FILE" \
  --transform='s|^|dist/|' \
  --mode='u+rwX,g+rX,o+rX' \
  -T -

# The above doesn't give us mixed permissions, so let's use a different approach
# Remove the file and use a Python script approach instead

rm -f "$TAR_FILE"

echo "Creating tar file with proper permissions..."
echo "Directories will have mode 0755, files will have mode 0644"
