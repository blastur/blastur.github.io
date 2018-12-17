#!/bin/bash

if [ "$#" -ne 1 ] ; then
  echo "usage: $0 <title>" >&2
  exit 1
fi

TITLE="$1"
THISDIR=$(readlink -f $(dirname $0))
POSTDIR="$(readlink -f ${THISDIR}/_posts/)"
TODAY=$(date +"%Y-%m-%d")
SAFE_TITLE=$(echo $TITLE | sed -e 's/[åä]/a/g' | sed -e 's/[ö]/o/g' | sed -e 's/[^A-Za-z0-9._-]/_/g' | tr '[:upper:]' '[:lower:]')
POST_FILENAME="$POSTDIR/$TODAY-$SAFE_TITLE.markdown"

if [ -f "$POST_FILENAME" ]; then
	echo "error: $POST_FILENAME already exists." >&2
	exit 1
fi

cat > $POST_FILENAME << EOF
---
layout: post
title: "$TITLE"
date:  `date "+%Y-%m-%d %H:%M:%S %z"`
categories:
---
# $TITLE

..
EOF

echo $POST_FILENAME