#!/bin/bash

echo "🔧 Fixing all Contact and Let's talk links across ALL pages..."

for file in *.html; do
  if [ -f "$file" ]; then
    echo "Processing $file..."
    
    # Fix all variations of Contact links pointing to /contact or contact.html
    sed -i '' 's|href="[^"]*contact[^"]*"|href="mailto:hanstoodeo@gmail.com?subject=Contact%20HandeoDesign"|g' "$file"
    sed -i '' 's|href="https://hanstoodeo.github.io/contact"|href="mailto:hanstoodeo@gmail.com?subject=Contact%20HandeoDesign"|g' "$file"
    sed -i '' 's|href="https://hanstoodeo.github.io/handeodesign/contact"|href="mailto:hanstoodeo@gmail.com?subject=Contact%20HandeoDesign"|g' "$file"
    
    # Fix all variations of "Let's talk" links
    sed -i '' 's|href="[^"]*">Let.*s talk</a>|href="mailto:hanstoodeo@gmail.com?subject=Let%27s%20Talk">Let'\''s talk</a>|g' "$file"
    
    echo "✅ Fixed $file"
  fi
done

echo ""
echo "✅ ALL pages fixed!"
echo ""
echo "Now committing and pushing to GitHub..."

git add .
git commit -m "Batch fix: Update all Contact and Let's talk links to email hanstoodeo@gmail.com across all pages"
git push origin main

echo ""
echo "🎉 DONE! All changes pushed to GitHub!"
