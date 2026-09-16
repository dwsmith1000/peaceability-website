# Peaceability Website Deployment Guide

## Current Issue
The website (peaceability.net) is showing "Index of /" or 404 errors because file/directory permissions are incorrect on the web server.

## Solution

### Files Provided
1. **PeaceAbility-dist-YYYY-MM-DD-HHMMSS.tar.gz** - Website files with proper permissions embedded
2. **fix_permissions.sh** - Script to ensure permissions are correct after extraction

### Step-by-Step Deployment

#### 1. Upload the Tar File
- Log into cPanel at https://peaceability.net:2083
- Go to File Manager
- Navigate to `/public_html`
- Upload `PeaceAbility-dist-YYYY-MM-DD-HHMMSS.tar.gz`

#### 2. Extract the Tar File
- Right-click the tar.gz file in cPanel
- Select "Extract"
- It will extract to a `dist/` folder

#### 3. Replace Existing Files (if needed)
If you need to move files from `dist/` to replace the existing public_html contents:
- Extract to `dist/`
- Move/copy the contents of `dist/` to replace files in `public_html/`
- Or delete old files and extract directly to the root

#### 4. Fix Permissions (Critical!)
**Important:** After extraction, you MUST fix the file permissions because the web server needs to read these files.

**Option A: Using the Command Line (SSH)**
```bash
cd /home/peaceabi/public_html
chmod -R 755 *
find . -type f -exec chmod 644 {} \;
```

**Option B: Using cPanel File Manager**
1. Select all files/folders in public_html
2. Right-click and select "Change Permissions"
3. Set to 755 for directories, 644 for files
   - This may require doing directories and files separately

#### 5. Verify the Website
- Visit https://peaceability.net in your browser
- You should see the website content, not "Index of /"

## Permission Details

### Why These Permissions?
- **Directories (0755)**: Owner can read/write/execute, others can read/execute (needed for web server to access)
- **Files (0644)**: Owner can read/write, others can only read (web server needs read access)

### Current Problem
Files are showing:
- Directories: 0700 (too restrictive - web server can't access)
- Files: 0600 (too restrictive - web server can't read)

This prevents Apache from serving the files, resulting in 404 errors.

## Troubleshooting

### Still seeing "Index of /" after fixing permissions?
1. Clear your browser cache (Cmd+Shift+Delete on Mac)
2. Verify permissions were actually changed in cPanel
3. Wait 5-10 minutes for cPanel to refresh
4. Check that index.html is in the public_html root

### Still seeing 404 errors?
1. Verify the dist/ folder was extracted completely
2. Check that all subdirectories exist:
   - dist/en/
   - dist/fr/
   - dist/images/
   - dist/admin/
   - dist/_astro/
   - dist/chunks/
3. Re-run the permission fix script

## Future Deployments

The tar files created with the Python script already have correct permissions embedded:
- This tar file will preserve 0755 for directories and 0644 for files when extracted
- Always run the fix_permissions.sh script after extraction to ensure permissions are correct

## Questions?
If you continue to have issues, you can:
1. Check cPanel error logs for 403/404 errors
2. Verify the web server user has read access to all files
3. Contact Hawk Host support if there's a web server configuration issue

