#!/bin/bash
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
if ! command -v npm-um > /dev/null
then
read -p "
'npm-um' command is not installed yet, would you like to install it? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
if [ ! -f ~/.bash_aliases ]
then
echo "
.bash_aliases file does not exist.
Creating it..."
touch ~/.bash_aliases
fi
echo "Adding 'npm-um' command..."
echo "alias npm-um='bash <(curl -s https://raw.githubusercontent.com/xaviermaillou/shell_scripts/master/npmUM.sh)'" >> ~/.bash_aliases
fi
echo "NPM Update Manager is now accessible from 'npm-um' command."
fi
echo "
Now, let's see what I can do for you..." 

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
echo "
Thank you for using NPM Update Manager.
"
else
echo "
Thank you for using NPM Update Manager.
"
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

Thank you for using NPM Update Manager.
"
else
read -p "
Do you want to update NPM? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
sudo npm install -g npm@latest
echo "
Thank you for using NPM Update Manager.
"
else
echo "
Thank you for using NPM Update Manager.
"
exit
fi
fi