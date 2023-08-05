#!/bin/bash

# Allows to easily update the CMake submodule in one quick swoop~
# @author Alexander Hinze
# @since 06/08/2023

export PREV_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git checkout develop
cd cmake
git pull
cd ..
git add -A
git commit -m "Update CMake submodule to latest commit"
git push
git checkout master
git merge develop
git push
git checkout $PREV_BRANCH
