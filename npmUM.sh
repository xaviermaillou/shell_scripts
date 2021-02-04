#!/bin/bash

# NPM Update Manager is a small shell script (only for Linux and macOS)
# Its purpose is to provide a friendly interface to check your NPM version,
# to update it if needed, or to install NPM if you don't have it yet.
#
# The easiest way to run NPM Update Manager is to execute it from your CLI:
# bash <(curl -H 'Cache-control: no-cache' -s https://raw.githubusercontent.com/xaviermaillou/shell_scripts/master/npmUM.sh)

ending_function() {
if ! [ -f ~/.bash_aliases ]
then
touch ~/.bash_aliases
fi

if ! grep -q "npm-um" ~/.bash_aliases
then
read -p "
'npm-um' command is not installed yet, would you like to install it? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Adding 'npm-um' command..."
echo "alias npm-um=\"bash <(curl -H 'Cache-control: no-cache' -s https://raw.githubusercontent.com/xaviermaillou/shell_scripts/master/npmUM.sh)\"" >> ~/.bash_aliases
echo -e "${BLUE}NPM Update Manager is now accessible from 'npm-um' command.${NC}"
fi
fi

echo "
Thank you for using NPM Update Manager. See ya!
________________________________________________________________________________
"
exit
}
BLUE='\033[1;34m'
GRAY='\033[0;37m'
NC='\033[0m'
echo -e "
________________________________________________________________________________

${BLUE}NPM UPDATE MANAGER
${GRAY}by XAVIER JEAN${NC}
________________________________________________________________________________

Hi there! 
NPM Update Manager will help you to update NPM, the Node.js package manager!"
sleep 2
echo "
Ok, let's see what I can do for you..." 

if ! command -v npm > /dev/null
then
read -p "
NPM is not installed yet, would you like to install it? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
curl -O https://npmjs.org/install.sh
sudo sh install.sh
ending_function
else
ending_function
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
echo -e "
${BLUE}Your NPM is up to date!${NC}
"
ending_function
else
read -p "
Do you want to update NPM? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
sudo npm install -g npm@latest
echo -e "
${BLUE}Your NPM is now up to date!${NC}
"
ending_function
else
ending_function
fi
fi