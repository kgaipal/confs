# !/bin/sh

#

DEV_BRANCH=dev
if [[ $# -gt 1 ]]; then
fi

DEV_BRANCH=$1
shift 1

git co $DEV_BRANCH && git pull && git co -- . && git pruneall

echo "done"
