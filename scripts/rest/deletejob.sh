#!/bin/bash

NAME=${1}
URL=${2:-http://localhost:8080}

curl ${URL}/job/${NAME}/doDelete -X POST --user akira-tokunaga:74475a159e15e7dd6e9dce4607425873
