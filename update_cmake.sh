#!/bin/bash

# Allows to easily update the CMake submodule in one quick swoop~
# @author Alexander Hinze
# @since 06/08/2023

export PREV_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ `git rev-parse --verify develop 2>/dev/null` ]; then
	export HAS_DEVELOP=true
	git checkout develop
fi

cd cmake
git pull
cd ..
git add -A
git commit -m "Update CMake submodule to latest commit"
git push

if [ "$HAS_DEVELOP" = true ]; then
	git checkout master
	git merge develop
	git push
fi

git checkout $PREV_BRANCH
