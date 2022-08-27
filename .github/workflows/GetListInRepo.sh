#!/bin/sh

git clone https://github.com/dino920135/Notes
cd Notes

echo "$PWD"

data_path='./pages/'
file_pattern='*.md'

for directory in $(find ${data_path} -name ${file_pattern})
do
    # echo $directory
    file_dir=$(dirname "$directory")
    file_name=$(basename "$file_dir")
    echo founnd $file_name
done

