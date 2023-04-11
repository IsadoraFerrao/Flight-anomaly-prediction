#!/bin/bash

export GPR_PROJECT_PATH=/usr/local/share/gpr

# perform instructions

#generate the tb
./main "$1/xml_out.xml" "$1"

#copy files to the directory of test
for file in "$1"/*; do
  # check if file is not the one to exclude
  if [ "$file" != "$1/xml_out.xml" ]; then
    # copy file
    #echo "$file"    
    cp "$file" "$2"
  fi
done


# exit
exit 0




