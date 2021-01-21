#!/bin/bash
BLUE='\033[1;34m'
GRAY='\033[0;37m'
NC='\033[0m'
echo -e "
________________________________________________________________________________

${BLUE}NPM UPDATE MANAGER
${GRAY}by XAVIER JEAN${NC}
________________________________________________________________________________

Hello there! 
I'm going to help you to update NPM, the Node.js package manager!"
sleep 2
read -p " 
First, tell me your name: " name
echo "
Ok then, "$name", let's see what I can do for you..." 

if ! which npm > /dev/null
then
read -p "
NPM is not installed, would you like to install it? " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
curl -O https://npmjs.org/install.sh
sh install.sh
else
exit
fi
fi

newVersion=$(npm view npm version)
actualVersion=$(npm -v)

echo "
The latest available NPM version is:
$newVersion"
echo "
Your NPM version is:
$actualVersion"

if [ ${actualVersion//.} -eq ${newVersion//.} ];
then
echo "
Your NPM is up to date!

"
else
read -p "
Do you want to update NPM? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
npm update -g
else
exit
fi
fi