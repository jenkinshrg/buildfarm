#!/bin/bash

NAME=${1}
URL=${2:-http://localhost:8080}

curl ${URL}/computer/${NAME}/config.xml --user akira-tokunaga:74475a159e15e7dd6e9dce4607425873
