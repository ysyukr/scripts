#!/bin/bash

echo "This script is for checking outdated files of Korean team."
This script must be run from the website folder."

rm -rf ./outdated-ko.txt
rm -rf ./outdated-en.txt
rm -rf ./docs-ko.txt

echo -e "Previous branch name: "
read prebranch
echo "Entered branch name: $prebranch"

echo -e "Current branch name: "
read currbranch
echo "Entered branch name: $currbranch"

echo "Check for differences between branches with the git diff command."

git diff --name-only upstream/"$prebranch" upstream/"$currbranch" -- content/en/docs >> outdated-en.txt

sed -e 's/content\/en/content\/ko/g' outdated-en.txt > outdated-en.txt.tmp

mv outdated-en.txt.tmp outdated-en.txt

find content/ko/docs >> docs-ko.txt

comm -12 outdated-en.txt docs-ko.txt >> outdated-ko.txt

rm -rf ./outdated-en.txt
rm -rf ./docs-ko.txt

echo "Check the contents of the outdated-ko.txt file."
