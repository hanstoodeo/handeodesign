#!/bin/bash

# Create archive directory
mkdir -p complete_archive
cd complete_archive

# Download complete pages with all resources (CSS, images, fonts, etc.)
wget -r --page-requisites --no-parent --convert-links \
  https://www.handeodesign.co.uk/ \
  https://www.handeodesign.co.uk/news \
  https://www.handeodesign.co.uk/news/turning-50 \
  https://www.handeodesign.co.uk/news/top-1-mentors \
  https://www.handeodesign.co.uk/news/one-dialogue-at-a-time \
  https://www.handeodesign.co.uk/news/the-power-of-the-first-step \
  https://www.handeodesign.co.uk/news/mentoring-matter \
  https://www.handeodesign.co.uk/news/meet-han-the-founder \
  https://www.handeodesign.co.uk/news/introducing-handeodesign \
  https://www.handeodesign.co.uk/work-in-progress

echo "✅ Complete archive downloaded with all CSS, images, and fonts!"
ls -lah
