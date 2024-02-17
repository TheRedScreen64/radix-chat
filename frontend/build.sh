# /usr/bin/bash 

corec=(utils/SHashmap.c
       utils/Convert.c
       utils/SString.c
       utils/String/String.c
       utils/SQTree/SQTreeSlowLocal.c
       utils/debug.c
       app/RadixApplication.c
       app/RadixGTK.c
       WSLocal.c
       Main.c)

os=$(grep -oP '(?<=PRETTY_NAME=").*(?=")' /etc/os-release)
coreoptions=(-D_VERSION='"'"$version_full"'"' -D_OS='"'"$os"'"') # -D_VERSION="0.1"
arguments=()

mkdir -p out

gcc "${corec[@]}" "$@" "${coreoptions[@]}" -DUTIL_DEBUG_CMPL -o out/core $(pkg-config --cflags --libs webkit2gtk-4.0) -lmicrohttpd

# assemble html code
chmod +x ./html/build.sh
./html/build.sh
