#!/bin/bash
if [ "$#" -eq 0 ]; then
	echo "No command/process type specified"
        exit 1
fi

if [ ! -d "/app" ]; then
	if [ -n "$GIT_REPO" ]; then
          rm -rf /build/buildpacks
          mkdir -p /build/buildpacks
          cd /build/buildpacks
          xargs -L 1 git clone --depth=1 < /build/buildpacks.txt
          git clone "$GIT_REPO" /app
          /build/builder
	else
		echo "No \$GIT_REPO environment variable defined"
		exit 1
	fi
fi

exec /exec "$@"
