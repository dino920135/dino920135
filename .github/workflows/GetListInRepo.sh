git show
cd ../
git clone https://github.com/dino920135/Notes
echo "$PWD"

cd Notes/pages
echo "$PWD"

######### Remove Old Lists ##########

# only delete between patterns
# sed -i '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/{/BLOG-POST-LIST:START/n;/BLOG-POST-LIST:END/!d;}' ../../dino920135/README.md 
sed -i '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/{//!d}' ../../dino920135/README.md 

# include start & end pattern
# sed '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/d' ../../dino920135/README.md 

sed -i '/.md]/d' ../../dino920135/README.md
# cat ../../dino920135/README.md

# echo "<!-- BLOG-POST-LIST:START -->" >> ../../dino920135/README.md
#for dir in $(ls -t $PWD/*md | tail -n +5)
# for dir in $(git log --pretty='' --name-only -- $PWD/*.md| awk '!seen[$0]++' | head -n 10)
for dir in $(git ls-tree --name-only -r HEAD -- *.md | sort -r | head -n 10)
do 
  file_name=$(basename "$dir")
  page_name=${file_name%.md}
  echo $page_name
  #file_name=$dir
  
  # Replace spaces with %20 in the page name
  page_name_encoded=$(echo "$page_name" | sed 's/ /%20/g')
  
#   file_name_wospace=$file_name | sed -e "s/ /%20/g"
#   echo $file_name_wospace
#   str='- [$file_name](https://github.com/dino920135/Notes/blob/main/pages/$file_name)'
  sed -i "/BLOG-POST-LIST:END/i - [$page_name](https://dino920135.github.io/Notes//#/page/$page_name_encoded)" ../../dino920135/README.md
#   echo "* [$file_name](https://github.com/dino920135/Notes/blob/main/pages/$file_name)" >> ../../dino920135/README.md
done
# echo "<!-- BLOG-POST-LIST:END -->" >> ../../dino920135/README.md
cat ../../dino920135/README.md
