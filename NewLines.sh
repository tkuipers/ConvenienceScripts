#!/bin/sh; !C:/Program\ Files/Git/usr/bin/sh.exe

files=$(git diff-index --name-status --cached HEAD | grep -v ^D | cut -c3-)
if [ "$files" != "" ]
then
  for f in $files
  do
    if [[ "$f" =~ [.](conf|css|erb|html|js|json|log|properties|rb|ru|txt|xml|yml|h|m|gs|gsx|sh)$ ]]
    then
      # Add a linebreak to the file if it doesn't have one
      if [ "$(tail -c1 $f)" != '\n' ]
      then
        echo >> $f
        git add $f
      fi

      # Remove trailing whitespace if it exists
      if grep -q "[[:blank:]]$" $f
      then
        sed -i "" -e $'s/[ \t]*$//g' $f
        git add $f
      fi

      #Remove multiple blank lines
      sed -i "" -e '/^$/N;/^\n$/D' $f
      git add $f
    fi
  done
fi