#!/bin/bash

echo "github username: "; read GITHUBUSERNAME
echo "project name: "; read REPONAME
echo "project description:"; read REPODESCRIPTION
echo "add interactive then commit? y/n"; read MUSTADD
echo "set a remote name: "; read REMOTENAME

GITHUBUSERNAME=${GITHUBUSERNAME// /\ } 
REPONAME=${REPONAME// /-} 
REPODESCRIPTION=${REPODESCRIPTION// /\ }
REMOTENAME=${REMOTENAME// /-} 
REPOURL=https://github.com/$GITHUBUSERNAME/$REPONAME

echo "\ncreating remote repository.."
curl -u "$GITHUBUSERNAME" https://api.github.com/user/repos -d '{"name":"'"$REPONAME"'","description":"'"$REPODESCRIPTION"'"}'
echo "\ndone."
echo "\nrepository remote url: $REPOURL"

git init
git remote add $REMOTENAME $REPOURL

if [[ "$MUSTADD" = "y" || "$MUSTADD" = "Y" ]] 
  then

  git add -i

  echo "\ncommiting content.."

  git commit -m "chore(project): pushing from mkhub.sh"

fi

echo "\npushing repository.."
git push -u origin master



