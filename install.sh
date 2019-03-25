#!/bin/sh

#run the recipie
cfmatrix/bin/box recipe recipeFile=cfmatrix/ci.boxr CFENGINE=$CFENGINE

# if box.json installed a command the server start may fail
# because commandbox reloads shell, so check if port is listening
lsof -i -P -n | fgrep LISTEN | fgrep ':8123' > /tmp/ports

if [[ $(cat "/tmp/ports") =~ ":8123" ]]; then
    echo "Server Listening on port 8123"
    cat /tmp/ports
else
    echo "Server Not Started, attempting to start"
    cfmatrix/bin/box server start cfengine=$CFENGINE port=8123 JVMArgs="-Djava.security.egd=file:/dev/./urandom" openbrowser=false
fi
