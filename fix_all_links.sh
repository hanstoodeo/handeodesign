#!/bin/bash

for file in *.html; do
  if [ -f "$file" ]; then
    echo "Fixing $file..."
    
    # Fix "Let's talk" links to email
    sed -i '' 's|href="[^"]*talk[^"]*"|href="mailto:hanstoodeo@gmail.com?subject=Let%27s%20Talk"|g' "$file"
    sed -i '' "s|>[Ll]et['\'']*s talk</a>|>Let's talk</a>|g" "$file"
    
    # Fix Contact navigation link to email
    sed -i '' 's|href="[^"]*contact[^"]*">Contact|href="mailto:hanstoodeo@gmail.com?subject=Contact%20HandeoDesign">Contact|g' "$file"
    
    # Fix footer logo to link home
    sed -i '' 's|<a[^>]*href="[^"]*handeo[^"]*logo[^"]*"[^>]*>|<a href="index.html">|g' "$file"
    
    echo "✅ Fixed $file"
  fi
done

echo "✅ All links fixed!"
