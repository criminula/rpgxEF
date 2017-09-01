#!/bin/sh

CMD_PREFIX="amd64-mingw32msvc x86_64-w64-mingw32";

# Set CC to correct compiler
if [ "X$CC" = "X" ]; then
    for check in $CMD_PREFIX; do
        full_check="${check}-gcc"
	if [ ! $(which "$full_check") = "" ]; then
	    export CC="$full_check"
	fi
    done
fi

# Set WINDRES to correct compiler
if [ "X$WINDRES" = "X" ]; then
    for check in $CMD_PREFIX; do
        full_check="${check}-windres"
	if [ ! $(which "$full_check") = "" ]; then
	    export WINDRES="$full_check"
	fi
    done
fi

# Add mingw header files to PATH
for check in $CMD_PREFIX; do
    INCLUDE_DIR="/usr/${check}";
    if [ ! $PATH = *"$INCLUDE_DIR"* ] && [ -d "$INCLUDE_DIR" ] ; then
	    export PATH="$INCLUDE_DIR:$PATH"
    fi
done

if [ "X$WINDRES" = "X" -o "X$CC" = "X" ]; then
    echo "Error: Must define or find WINDRES and CC"
    exit 1
fi

export PLATFORM=mingw32
export ARCH=x64

exec make $*
