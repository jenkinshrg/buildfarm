#!/bin/bash

NAME=${1}
RFS=${2:-$HOME}
URL=${3:-http://localhost:8080}

cat << EOL | curl ${URL}/computer/doCreateItem?name=${NAME} -X POST --user akira-tokunaga:74475a159e15e7dd6e9dce4607425873 --data-urlencode json@-
{ "name":"${NAME}","type":"hudson.slaves.DumbSlave$DescriptorImpl" }
EOL
