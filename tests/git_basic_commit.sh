#!/bin/bash

# Test unique to this task

# setup
BRANCH_NAME=add-self-introduction
PROJECT_DIR=$(dirname $(cd $(dirname $0); pwd))
RED='\033[0;31m'
NC='\033[0m' # No Color
cd "$PROJECT_DIR"

## check that only hello.txt is changed

CHANGED_FILES=$(git diff --name-only main origin/${BRANCH_NAME})

# Check to see if a remote branch exists
if git ls-remote --heads origin | grep -q $BRANCH_NAME ; then
    # do nothing
    :
else
    echo -e "${RED}Remote branch ${BRANCH_NAME} does not exist.${NC}"
    exit 1
fi

MAIN_BRANCH="main"

# Get the latest commit hash of the main branch in the local repository
local_main_commit=$(git rev-parse $MAIN_BRANCH)

# Get the latest commit hash of the main branch of the remote repository
remote_main_commit=$(git rev-parse origin/$MAIN_BRANCH)

# Check that the latest commit hash of the main branch in the local repository is the same as the latest commit hash in the remote repository
if [ "$local_main_commit" != "$remote_main_commit" ]; then
    # do nothing
    :
else
    echo "${RED}You have not pulled any changes into $MAIN_BRANCH.${NC}"
    exit 1
fi

echo "ok"
exit 0
