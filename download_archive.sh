#!/bin/bash

# Create archive directory
mkdir -p archive

# Download all pages
curl -s https://www.handeodesign.co.uk -o archive/index.html
curl -s https://www.handeodesign.co.uk/news -o archive/news.html
curl -s https://www.handeodesign.co.uk/news/turning-50 -o archive/article-turning-50.html
curl -s https://www.handeodesign.co.uk/news/top-1-mentors -o archive/article-top-1-mentors.html
curl -s https://www.handeodesign.co.uk/news/one-dialogue-at-a-time -o archive/article-one-dialogue.html
curl -s https://www.handeodesign.co.uk/news/the-power-of-the-first-step -o archive/article-first-step.html
curl -s https://www.handeodesign.co.uk/news/mentoring-matter -o archive/article-mentorship-matters.html
curl -s https://www.handeodesign.co.uk/news/meet-han-the-founder -o archive/article-meet-han.html
curl -s https://www.handeodesign.co.uk/news/introducing-handeodesign -o archive/article-introducing.html
curl -s https://www.handeodesign.co.uk/work-in-progress -o archive/work-in-progress.html

echo "✅ All pages downloaded to ./archive/"
ls -la archive/
