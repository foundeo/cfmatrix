#!/bin/sh

#install commandbox 
curl -SL -o box.zip https://www.ortussolutions.com/parent/download/commandbox/type/bin
ls -lah | grep box.zip
unzip box.zip -d cfmatrix/bin/ && rm -v box.zip

#for boxlang install bx compat 
if [[ "$CFENGINE" == *"boxlang"* ]];then
    cfmatrix/bin/box install bx-compat-cfml
fi

#if boxlang and no javaversion set to 21
if [[ "$CFENGINE" == *"boxlang"* ]] && [[ -z "$JAVAVERSION" ]]; then
    export JAVAVERSION="openjdk21"
fi

#run the recipie
cfmatrix/bin/box recipe recipeFile=cfmatrix/ci.boxr CFENGINE=$CFENGINE JAVAVERSION=$JAVAVERSION

# if box.json installed a command the server start may fail
# because commandbox reloads shell, so check if port is listening
lsof -i -P -n | fgrep LISTEN | fgrep ':8123' > /tmp/ports

if [[ $(cat "/tmp/ports") =~ ":8123" ]]; then
    echo "Server Listening on port 8123"
    cat /tmp/ports
else
    echo "Server Not Started, attempting to start"
    cfmatrix/bin/box server start cfengine=$CFENGINE port=8123 JVMArgs="-Djava.security.egd=file:/dev/./urandom" openbrowser=false javaVersion=$JAVAVERSION
fi
