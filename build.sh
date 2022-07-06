#!/bin/bash
## update on run
##
## Tests about standalone executables (incomplete)
##
git submodules init update
update(){
        CURRENT_VERS=$(cat ".litversion")
        GITHUB_VERS=$(curl "https://raw.githubusercontent.com/Litium-org/litium/master/.litversion")
        if [ $CURRENT_VERS<$GITHUB_VERS ]
        then
                echo "Version mismatch"
                echo "Current version: $CURRENT_VERS"
                echo "Most recent version: $GITHUB_VERS"
                git pull
        fi
}
srlua(){
        cd srlua-102
        make
        sudo make install
        cd ..
}
compile(){

        return true
}
update
echo "Compiling..."
if [ !compile ] 
then
        echo "Build unsuccessful"
else    
        echo "Build finished successfully"
fi
