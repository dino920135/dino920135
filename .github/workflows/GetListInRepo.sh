cd ../
git clone https://github.com/dino920135/Notes
echo "$PWD"

cd Notes/pages
echo "$PWD"

# data_path='./pages/'
# file_pattern='*.md'

# Remove Old Lists
sed -n '1,/BLOG-POST-LIST:START/p;/BLOG-POST-LIST:END/,$p' myfile # only delete between patterns

cat ../../dino920135/README.md

for dir in $PWD/*md
do 
  file_name=$(basename "$dir")
  # Fixme replace spaces with %20
  file_name_wospace=$file_name | sed -e "s/ /%20/g"
  echo $file_name_wospace
  echo "* [$file_name](https://github.com/dino920135/Notes/blob/main/pages/$file_name)" >> ../../dino920135/README.md
done

cat ../../dino920135/README.md

# for directory in $(find ${data_path} -name ${file_pattern})
# do
#     # echo $directory
#     file_dir=$(dirname "$directory")
#     file_name=$(basename "$file_dir")
#     echo found $file_name
# done

