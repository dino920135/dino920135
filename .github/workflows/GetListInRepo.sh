#!/bin/sh
# Usage: GetListInRepo.sh <notes-repo-dir> <target-file>
#
# Rewrites the lines between the BLOG-POST-LIST:START / BLOG-POST-LIST:END markers in
# <target-file> with the ten most recently edited Logseq pages and journals.

NOTES="$1"
TARGET="$2"
BASE="https://dino920135.github.io/Notes/#/page"

######### Remove Old List ##########

# Delete everything strictly between the two markers (the markers themselves stay).
sed -i '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/{//!d}' "$TARGET"

######### Fetch Most Recently Modified 10 Files ##########

# The pathspecs are quoted so git matches them against history, not the shell against
# the working tree. `awk '!seen[$0]++'` keeps the first (most recent) mention of each
# file, and files that no longer exist are skipped before taking the top ten.
git -C "$NOTES" log --pretty='' --name-only -- 'pages/*.md' 'journals/*.md' \
  | awk '!seen[$0]++' \
  | while read -r path; do
      [ -f "$NOTES/$path" ] && echo "$path"
    done \
  | head -n 10 \
  | while read -r path; do
      file_name=$(basename "$path" .md)

      case "$path" in
        journals/*)
          # 2026_05_25 -> "May 25th, 2026", Logseq's default journal title format.
          ymd=$(echo "$file_name" | tr '_' '-')
          day=$(date -d "$ymd" '+%-d')
          case "$day" in
            1|21|31) suffix=st ;;
            2|22)    suffix=nd ;;
            3|23)    suffix=rd ;;
            *)       suffix=th ;;
          esac
          page_name="$(date -d "$ymd" '+%b') ${day}${suffix}, $(date -d "$ymd" '+%Y')"
          ;;
        *)
          # Namespaced pages are stored as "Dev%2FGit.md"; display them as "Dev/Git".
          page_name=$(echo "$file_name" | sed 's/%2F/\//g')
          ;;
      esac

      # Spaces -> %20; "/" is re-encoded so a namespace stays one URL segment.
      page_name_encoded=$(echo "$page_name" | sed -e 's/\//%2F/g' -e 's/ /%20/g')
      echo "$page_name"

      line="- [$page_name]($BASE/$page_name_encoded)"

      # Insert above the END marker, so items keep their most-recent-first order.
      # (Backslashes are escaped because sed's i command treats them specially.)
      line=$(echo "$line" | sed 's/\\/\\\\/g')
      sed -i "/BLOG-POST-LIST:END/i $line" "$TARGET"
    done

# Output the updated list to verify changes
sed -n '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/p' "$TARGET"
