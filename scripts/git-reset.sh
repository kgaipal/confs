# !/bin/sh

#

if [[ $# -lt 1 ]]; then
    echo $#
    echo "Usage: $0 DEV_BRANCH like {dev, develop, etc}"
    exit 1
fi

DEV_BRANCH=$1
shift 1

git co $DEV_BRANCH && git pull && git co -- . && git pruneall

echo "done"
