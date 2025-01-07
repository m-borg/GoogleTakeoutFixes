#!/bin/bash

# Check if ImageMagick is installed
if ! command -v magick &> /dev/null; then
    echo "ImageMagick is required but not installed. Please install it first:"
    echo "brew install imagemagick"
    exit 1
fi

# Process all jpg files in current directory
for file in *.jpg; do
    # Skip if no files found
    [[ -e "$file" ]] || continue
    
    # Check if file is actually WebP
    if file "$file" | grep -q "Web/P"; then
        echo "Processing $file..."
        
        # Get original timestamps
        created=$(stat -f %B "$file")
        modified=$(stat -f %m "$file")
        
        # Create new filename
        newfile="${file%.*}_converted.jpg"
        
        # Convert to actual JPEG
        magick "$file" -quality 95 "$newfile"
        
        # Restore timestamps
        touch -t "$(date -r $created +%Y%m%d%H%M.%S)" "$newfile"
        touch -t "$(date -r $modified +%Y%m%d%H%M.%S)" "$newfile"
        
        # Remove original file
        rm "$file"
        
        # Rename new file to original name
        mv "$newfile" "$file"
        
        echo "Converted to JPEG: $file"
    else
        echo "$file is already a JPEG file, skipping..."
    fi
done
