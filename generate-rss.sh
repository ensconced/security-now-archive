#!/usr/bin/env bash

# Set these variables according to your setup
BASE_URL="http://192.168.111.22:8000"
RSS_FILE="podcast.rss"
TITLE="Security now (archive)"
LINK="http://192.168.111.22:8000"
DESCRIPTION="Security Now (archive)"

# Start the RSS feed file
cat <<EOF >$RSS_FILE
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
  <title>$TITLE</title>
  <link>$LINK</link>
  <description>$DESCRIPTION</description>
EOF

# Append an item for each MP3 file in the directory
for FILE in episodes/*.mp3; do
  FILENAME=$(basename "$FILE")
  PUBDATE=$(date -R -r "$FILE")
  FILE_SIZE=$(stat -f%z "$FILE")
  cat <<EOF >>$RSS_FILE
  <item>
    <title>${FILENAME%.mp3}</title>
    <link>$BASE_URL/$FILE</link>
    <enclosure url="$BASE_URL/$FILE" length="$FILE_SIZE" type="audio/mpeg" />
    <pubDate>$PUBDATE</pubDate>
  </item>
EOF
done

# Close the RSS feed file
cat <<EOF >>$RSS_FILE
</channel>
</rss>
EOF

echo "RSS feed generated in $RSS_FILE"
