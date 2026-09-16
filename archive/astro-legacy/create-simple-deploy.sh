#!/bin/bash
set -e

TMPDIR="/tmp/peace-simple-$$"
mkdir -p "$TMPDIR/dist-simple"
cd "$TMPDIR/dist-simple"

# Copy only the simple, static directories
cp -r /Users/computer/Documents/10\ At\ Home/70\ Special\ Projects/PeaceAbility-Website/dist/en .
cp -r /Users/computer/Documents/10\ At\ Home/70\ Special\ Projects/PeaceAbility-Website/dist/fr .
cp -r /Users/computer/Documents/10\ At\ Home/70\ Special\ Projects/PeaceAbility-Website/dist/images .
cp /Users/computer/Documents/10\ At\ Home/70\ Special\ Projects/PeaceAbility-Website/dist/index.html .

# Create a simple .htaccess that just serves static files
cat > .htaccess << 'HTACCESS'
DirectoryIndex index.html

<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^en$ /en/index.html [L]
RewriteRule ^fr$ /fr/index.html [L]
</IfModule>
HTACCESS

# Fix permissions
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

# Create tar with explicit permissions
cd /tmp
tar --mode=g+r,o+r --owner=0 --group=0 -czf "peaceability-simple-$(date +%Y%m%d-%H%M%S).tar.gz" -C "$TMPDIR" dist-simple/

echo "Created: /tmp/peaceability-simple-*.tar.gz"
ls -lh /tmp/peaceability-simple-*.tar.gz | tail -1

# Cleanup
rm -rf "$TMPDIR"
