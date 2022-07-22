#!/bin/bash
## @author : Dyp1xy
#
## Satisfy dependencies
## Update on run
## Tests about standalone executables (incomplete)

# constants
readonly WORKING_DIRECTORY=$(pwd)
readonly TRY_GIT_PULL=false
readonly GREEN='\033[0;32m' # Green output color
readonly NC='\033[0m' # No Color

# init/update submodules
git submodule update --init
# lua-https module (love)
lua-https() {
        cd build/lua-https/
        cmake -Bbuild -S. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD\install
        cmake --build build --target install

        echo "done" > done.txt
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Module [ lua-https ] installed "

        cd $WORKING_DIRECTORY
}
if [ -s build/lua-https/done.txt ]
then
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Module lua-htpps already installed"
else
        lua-https
fi

update(){
        if $TRY_GIT_PULL ; then
                git pull
        else
                echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Not checking for updates"
        fi
}
update
