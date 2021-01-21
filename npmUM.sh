#!/bin/bash
BLUE='\033[1;34m'
GRAY='\033[0;37m'
NC='\033[0m'
echo -e "
________________________________________________________________________________

${BLUE}NPM UPDATE MANAGER
${GRAY}par XAVIER JEAN${NC}
________________________________________________________________________________

Bonjour! 
Je vais vous aider à mettre à jour NPM, l'administrateur de paquets de Node.js !"
sleep 2
read -p " 
D'abord, dites-moi votre nom : " name
echo "
Très bien, "$name", voyons ce que je peux faire pour vous..." 

if ! which npm > /dev/null
then
read -p "
NPM n'est pas installé, voulez-vous l'installer ? Y/n " -n 1 -r
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
La dernière version de NPM disponible est:
$newVersion"
echo "
Votre version de NPM est:
$actualVersion"

if [ ${actualVersion//.} -eq ${newVersion//.} ];
then
echo "
Votre NPM est à jour !

"
else
read -p "
Voulez-vous mettre à jour NPM ? Y/n " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
npm update -g
else
exit
fi
fi