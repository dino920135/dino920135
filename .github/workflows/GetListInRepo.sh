#!/bin/sh

cd ../../../
git clone https://github.com/dino920135/Notes
echo "$PWD"

cd Notes/pages
echo "$PWD"

# data_path='./pages/'
# file_pattern='*.md'

for dir in $PWD/*md
do 
  file_name=${basename "$dir"}
  echo [$file_name](https://github.com/dino920135/Notes/pages/$file_name) >> ../../dino920135/README.md
done

cat ../../dino920135/README.md

# for directory in $(find ${data_path} -name ${file_pattern})
# do
#     # echo $directory
#     file_dir=$(dirname "$directory")
#     file_name=$(basename "$file_dir")
#     echo found $file_name
# done

