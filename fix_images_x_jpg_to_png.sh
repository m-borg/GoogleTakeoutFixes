#!/bin/bash

# Loop through all jpg files in current directory
for file in *.jpg; do
    # Check if file exists (to handle case when no jpg files are found)
    [ -f "$file" ] || continue
    
    # Get the real file type using file command
    filetype=$(file -b "$file" | awk '{print tolower($1)}')
    
    # If the file is actually a PNG
    if [[ $filetype == "png" ]]; then
        echo "Processing $file (actual type: PNG)"
        
        # Store original creation and modification dates
        created=$(GetFileInfo -d "$file")
        modified=$(GetFileInfo -m "$file")
        
        echo "Original dates - Created: $created, Modified: $modified"
        
        # New filename (replace .jpg with .png)
        newfile="${file%.jpg}.png"
        
        # Copy file with proper extension
        cp "$file" "$newfile"
        
        # Copy metadata
        exiftool -overwrite_original -TagsFromFile "$file" "$newfile" 2>/dev/null
        
        # Set the creation and modification dates
        SetFile -d "$created" "$newfile"
        SetFile -m "$modified" "$newfile"
        
        # Remove the original file only if new file exists and has size greater than 0
        if [ -s "$newfile" ]; then
            rm "$file"
            echo "Successfully converted $file to $newfile"
            
            # Verify dates
            echo "New file dates:"
            echo "Created: $(GetFileInfo -d "$newfile")"
            echo "Modified: $(GetFileInfo -m "$newfile")"
        else
            echo "Error converting $file"
            rm "$newfile" 2>/dev/null
        fi
        
        # Clean up any potential _original files
        rm -f "${newfile}_original" 2>/dev/null
    fi
done