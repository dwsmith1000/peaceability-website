#!/usr/bin/env python3
import tarfile
import os
import sys
from datetime import datetime
from pathlib import Path

def create_tar_with_proper_perms(source_dir="dist", output_file=None):
    """
    Create a tar.gz file with proper permissions for web deployment.
    Directories: 0755 (rwxr-xr-x)
    Files: 0644 (rw-r--r--)
    """
    
    if output_file is None:
        timestamp = datetime.now().strftime("%Y-%m-%d-%H%M%S")
        output_file = f"PeaceAbility-dist-{timestamp}.tar.gz"
    
    print(f"Creating {output_file} with proper permissions...")
    
    with tarfile.open(output_file, "w:gz") as tar:
        for root, dirs, files in os.walk(source_dir):
            # Add directories with 0755 permissions
            for dir_name in dirs:
                dir_path = os.path.join(root, dir_name)
                arcname = os.path.relpath(dir_path, ".")
                
                tarinfo = tar.gettarinfo(dir_path, arcname=arcname)
                tarinfo.mode = 0o755  # rwxr-xr-x
                tar.addfile(tarinfo)
            
            # Add files with 0644 permissions
            for file_name in files:
                file_path = os.path.join(root, file_name)
                arcname = os.path.relpath(file_path, ".")
                
                tarinfo = tar.gettarinfo(file_path, arcname=arcname)
                tarinfo.mode = 0o644  # rw-r--r--
                tar.addfile(tarinfo, open(file_path, "rb"))
    
    # Get file size
    file_size = os.path.getsize(output_file)
    size_kb = file_size / 1024
    size_mb = size_kb / 1024
    
    if size_mb >= 1:
        print(f"✓ Created: {output_file} ({size_mb:.2f} MB)")
    else:
        print(f"✓ Created: {output_file} ({size_kb:.2f} KB)")
    
    print(f"\nFile ready for upload to peaceability.net")
    print(f"After extraction, permissions will be:")
    print(f"  - Directories: 0755 (rwxr-xr-x)")
    print(f"  - Files: 0644 (rw-r--r--)")
    return output_file

if __name__ == "__main__":
    output = create_tar_with_proper_perms()
    print(f"\nOutput: {output}")
