#!/bin/bash
## @author : Dyp1xy
#
## Satisfy dependencies
## Update on run
## Tests about standalone executables (incomplete)

# constructors
if [ ! -d build/linux/lua_version ]
then
	mkdir build/linux/
fi
LUA_VERS=$(lua -v > build/linux/lua_version | awk '{ print substr($2,1,3)}' build/linux/lua_version)
LUA_HTTPS="/usr/lib/lua/$LUA_VERS/"

# constants, fell free to change
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
        cd lib/lua-https/
        cmake -B build -S. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD\install
        cmake --build build --target install
        cd $WORKING_DIRECTORY

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

compile(){
        if [ -e Litium.love ]
        then rm -v Litium.love
        fi

        # exclude unnecessary files to build	build directories, build and boot scripts, and non necessary files
        TO_EXCLUDE="*.sh build/ *.md *.txt CHANGELOG *.cmd .gitignore .gitmodules .litversion .git *.love"
        zip -9 -x $TO_EXCLUDE -r Litium.love .
}

#func calls
update
compile
