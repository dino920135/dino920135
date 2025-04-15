# Show the current git status (used for debugging purposes)
git show
# Move one level up in the directory structure
cd ../
# Clone the repository from GitHub into the current directory
git clone https://github.com/dino920135/Notes
echo "$PWD"

cd Notes/pages
echo "$PWD"

######### Remove Old Lists ##########

# Remove the section of the README.md file between the markers 'BLOG-POST-LIST:START' and 'BLOG-POST-LIST:END'.
# The '//!d' inside the curly braces deletes all lines in this range, effectively clearing the list.
sed -i '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/{//!d}' ../../dino920135/README.md 

# This command removes any lines containing '.md]' in the README.md file, which could be left over from previous links.
sed -i '/.md]/d' ../../dino920135/README.md
# cat ../../dino920135/README.md

######### Fetch Most Recent Modified 10 Files ##########

# The `git log` command retrieves the most recent changes in files with a `.md` extension.
# It uses the 'name-only' option to list just the filenames, and `awk '!seen[$0]++'` removes duplicates.
# The `head -n 10` limits the output to the most recent 10 unique files.
# We then process these files, handling those with spaces properly using the `while` loop.
git log --pretty='' --name-only -- $PWD/*.md | awk '!seen[$0]++' | head -n 10 | while read -r dir
do 
  # Extract the filename without the path using 'basename'
  file_name=$(basename "$dir")
  # Remove the '.md' extension from the filename to get the page name
  page_name=${file_name%.md}
  # Print the page name (used for debugging to ensure the correct filename is picked up)
  echo $page_name
  #file_name=$dir
  
  # Replace any spaces in the page name with '%20' for proper URL encoding
  page_name_encoded=$(echo "$page_name" | sed 's/ /%20/g')
  
  # Append a new list item to the README.md file under the 'BLOG-POST-LIST:END' marker
  # The link format is markdown style: - [page_name](URL)
  # This inserts a clickable link to the page based on the encoded page name
  sed -i "/BLOG-POST-LIST:END/i - [$page_name](https://dino920135.github.io/Notes//#/page/$page_name_encoded)" ../../dino920135/README.md
done

# Output the updated README.md content to verify changes
cat ../../dino920135/README.md
