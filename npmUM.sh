#!/bin/bash

# NPM Update Manager is a small shell script (only for Linux and macOS)
# Its purpose is to provide a friendly interface to check your NPM version,
# to update it if needed, or to install NPM if you don't have it yet.
#
# The easiest way to run NPM Update Manager is to execute it from your CLI:
# bash <(curl -H 'Cache-control: no-cache' -s https://raw.githubusercontent.com/xaviermaillou/shell_scripts/master/npmUM.sh)


# Checks OS type (Mac or Linux) and defines the file name where to add an potential alias
if [[ "$OSTYPE" == "darwin"* ]]
then
    aliasFile=".bash_profile"
    echo
    echo "macOS detected"
elif [[ "$OSTYPE" == "linux-gnu"* ]]
then
    aliasFile=".bashrc"
    echo
    echo "LINUX detected"
fi

# Function invoked at the end: proposes to add "npm-um" command
ending_function() {
    sleep 1
    if ! grep -q "npm-um" ~/$aliasFile
    then
        echo
        read -p "'npm-um' command is not installed yet, would you like to install it? Y/n " -n 1 -r
        echo
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Adding 'npm-um' command in $aliasFile..."
            echo "alias npm-um=\"bash <(curl -H 'Cache-control: no-cache' -s https://raw.githubusercontent.com/xaviermaillou/shell_scripts/master/npmUM.sh)\"" >> ~/$aliasFile
            echo -e "${BLUE}NPM Update Manager is now accessible from 'npm-um' command.${NC}"
        fi
    fi
    echo
    echo "Thank you for using NPM Update Manager. See ya!"
    echo "________________________________________________________________________________"
    echo
    exit
}

BLUE='\033[1;34m'
GRAY='\033[0;37m'
NC='\033[0m'

############ START ############
echo
echo "________________________________________________________________________________"
echo -e "${BLUE}NPM UPDATE MANAGER"
echo -e "${GRAY}by XAVIER JEAN${NC}"
echo "________________________________________________________________________________"
echo
echo "Hi there!"
echo "NPM Update Manager will help you to update NPM, the Node.js package manager!"
sleep 2
echo
echo "Ok then, let's see what I can do for you..." 

# Checks if NPM is not installed, if true it proposes to install it
if ! command -v npm > /dev/null
then
    echo
    read -p "NPM is not installed yet, would you like to install it? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then

        if [[ "$OSTYPE" == "linux-gnu"* ]] 
        then
            DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
            echo "updated"
            if [[ ${DISTRIB} = "Ubuntu"* ]] 
            then
                if uname -a | grep -q '^Linux.*Microsoft'
                then
                    # Ubuntu via WSL Windows Subsystem for Linux
                    echo "WSL for Linux"
                else
                    # native Ubuntu
                    sudo apt install nodejs npm
                fi
            elif [[ ${DISTRIB} = "Debian"* ]] 
            then
                # Debian
                sudo apt install nodejs npm
            elif [[ ${DISTRIB} = *"Cent"* ]] 
            then
                # CentOS
                echo "CentOS"
                sudo yum install nodejs npm
            fi
        elif [[ "$OSTYPE" == "darwin"* ]] 
        then
            # macOS OSX
            echo "macOS"
        fi

        # deprecated:
        # curl -L -O -s https://npmjs.org/install.sh
        # sudo ./install.sh

        ending_function
    else
    ending_function
    fi
fi

# Looks for both latest NPM version available, and installed version of NPM
newVersion=$(npm view npm version)
actualVersion=$(npm -v)

echo
echo "The latest available NPM version is:"
echo $newVersion
echo
echo "Your NPM version is:"
echo $actualVersion

# Compares versions: if different, it allows to update NPM
if [ ${actualVersion//.} -eq ${newVersion//.} ];
then
    echo
    echo -e "${BLUE}Your NPM is up to date!${NC}"
    echo
    ending_function
else
    echo
    read -p "Do you want to update NPM? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sudo npm install -g npm@latest
        echo
        echo -e "${BLUE}Your NPM is now up to date!${NC}"
        echo
        ending_function
    else
        ending_function
    fi
fi