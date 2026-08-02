#!/bin/bash

# Fix links for GitHub Pages
for file in *.html; do
  if [ -f "$file" ]; then
    # Fix canonical URLs
    sed -i '' 's|href="https://www.handeodesign.co.uk"|href="."|g' "$file"
    
    # Fix navigation links (remove /news/ prefix)
    sed -i '' 's|href="/news/turning-50|href="article-turning-50|g' "$file"
    sed -i '' 's|href="/news/top-1-mentors|href="article-top-1-mentors|g' "$file"
    sed -i '' 's|href="/news/one-dialogue-at-a-time|href="article-one-dialogue|g' "$file"
    sed -i '' 's|href="/news/the-power-of-the-first-step|href="article-first-step|g' "$file"
    sed -i '' 's|href="/news/mentoring-matter|href="article-mentorship-matters|g' "$file"
    sed -i '' 's|href="/news/meet-han-the-founder|href="article-meet-han|g' "$file"
    sed -i '' 's|href="/news/introducing-handeodesign|href="article-introducing|g' "$file"
    
    # Fix root links
    sed -i '' 's|href="/"|href="index.html"|g' "$file"
    sed -i '' 's|href="/news|href="news.html|g' "$file"
    sed -i '' 's|href="/work-in-progress|href="work-in-progress.html|g' "$file"
    
    echo "✅ Fixed links in $file"
  fi
done

echo "✅ All links fixed!"
