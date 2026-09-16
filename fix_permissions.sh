#!/bin/bash
# Fix permissions for the PeaceAbility static site after a cPanel tar extraction.
# Web servers on shared hosting need group/other read on files and read+execute
# on directories -- a plain tar extraction sometimes preserves overly-restrictive
# source permissions (e.g. 600/700) and Apache returns 403 Forbidden instead of
# serving the file. This is the same class of bug the old Astro build hit too.
#
# Usage (run from inside cPanel's Terminal app, or via SSH if you have it):
#   cd public_html               # or wherever you extracted the site
#   bash fix_permissions.sh      # fixes the current directory
#   bash fix_permissions.sh en   # fixes just one subfolder, if you only need that

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory $TARGET_DIR does not exist"
    exit 1
fi

echo "Fixing permissions in: $TARGET_DIR"
echo "=================================="

echo "Setting directories to 0755 (rwxr-xr-x)..."
find "$TARGET_DIR" -type d -exec chmod 755 {} \;

echo "Setting files to 0644 (rw-r--r--)..."
find "$TARGET_DIR" -type f -exec chmod 644 {} \;

echo "Done. Spot-check:"
find "$TARGET_DIR" -maxdepth 1 -type d | head -1 | xargs ls -ld
find "$TARGET_DIR" -maxdepth 1 -type f | head -1 | xargs ls -l
