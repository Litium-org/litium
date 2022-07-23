#!/bin/bash
## @author : Dyp1xy
#
## Satisfy dependencies
## Update on run
## Tests about standalone executables (incomplete)

# constructors
LUA_VERS=$(lua -v > build/linux/lua_version | awk '{ print substr($2,1,3)}' build/linux/lua_version)
LUA_HTTPS="/usr/lib/lua/$LUA_VERS/"

# constants
readonly WORKING_DIRECTORY=$(pwd)
readonly TRY_GIT_PULL=false
readonly GREEN='\033[0;32m' # Green output color
readonly YELLOW='\033[0;33m'
readonly NC='\033[0m' # No Color

# init/update submodules
git submodule update --init

# lua-https module (love)
lua-https() {
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Building lua-https..."
        cd build/lua-https/
        cmake -Bbuild -S. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD\install
        cmake --build build --target install
        cd ..

        # to general use
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} sudo password needed to copy lib file to ${YELLOW}$LUA_HTTPS ${NC}and ${YELLOW}/usr/lib/lua/5.1/"
        sudo cp "lua-httpsinstall/https.so" $LUA_HTTPS
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Copied [ https.so ] to $LUA_HTTPS ${YELLOW}(General use)"
        # to love use
        sudo cp "lua-httpsinstall/https.so" "/usr/lib/lua/5.1/"
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Copied [ https.so ] to /usr/lib/lua/5.1/ ${YELLOW}(Love use)"

        echo "done" > lua-https/done.txt
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
