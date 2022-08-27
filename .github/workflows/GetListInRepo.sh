#!/bin/sh

git clone https://github.com/dino920135/Notes
cd Notes

echo "$PWD"
echo

data_path='./pages/'
file_pattern='*.md'

for dir in **/pages/*/; do basename "$dir"; done

# for directory in $(find ${data_path} -name ${file_pattern})
# do
#     # echo $directory
#     file_dir=$(dirname "$directory")
#     file_name=$(basename "$file_dir")
#     echo found $file_name
# done

