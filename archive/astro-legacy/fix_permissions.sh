#!/bin/bash

# Fix permissions for Peaceability website deployment
# Run this script in the public_html directory after extracting the tar file
# Usage: bash fix_permissions.sh dist/

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory $TARGET_DIR does not exist"
    exit 1
fi

echo "Fixing permissions in: $TARGET_DIR"
echo "=================================="

# Fix directory permissions (0755)
echo "Setting directories to 0755 (rwxr-xr-x)..."
find "$TARGET_DIR" -type d -exec chmod 755 {} \;

# Fix file permissions (0644)
echo "Setting files to 0644 (rw-r--r--)..."
find "$TARGET_DIR" -type f -exec chmod 644 {} \;

echo "✓ Permissions fixed!"
echo ""
echo "Verification:"
find "$TARGET_DIR" -type d | head -1 | xargs ls -ld
find "$TARGET_DIR" -type f | head -1 | xargs ls -l
