git show
cd ../
git clone https://github.com/dino920135/Notes
echo "$PWD"

cd Notes/pages
echo "$PWD"

######### Remove Old Lists ##########

# only delete between patterns
# sed -n '1,/BLOG-POST-LIST:START/p;/BLOG-POST-LIST:END/,$p' ../../dino920135/README.md 

# include start & end pattern
# sed '/BLOG-POST-LIST:START/,/BLOG-POST-LIST:END/d' ../../dino920135/README.md 
# cat ../../dino920135/README.md

# echo "<!-- BLOG-POST-LIST:START -->" >> ../../dino920135/README.md
for dir in $PWD/*md
do 
  file_name=$(basename "$dir")
  # Fixme replace spaces with %20
  file_name_wospace=$file_name | sed -e "s/ /%20/g"
  echo $file_name_wospace
  str='- [$file_name](https://github.com/dino920135/Notes/blob/main/pages/$file_name)'
  sed '/BLOG-POST-LIST:START/a test' ../../dino920135/README.md
#   echo "* [$file_name](https://github.com/dino920135/Notes/blob/main/pages/$file_name)" >> ../../dino920135/README.md
done
# echo "<!-- BLOG-POST-LIST:END -->" >> ../../dino920135/README.md
cat ../../dino920135/README.md
