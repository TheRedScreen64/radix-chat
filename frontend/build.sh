# /usr/bin/bash 
corec=(utils/SHashmap.c
       utils/Convert.c
       utils/SString.c
       utils/String/String.c
       utils/SQTree/NMap.c
       utils/SQTree/SQTree.c
       utils/SQTree/SQTreeSlowLocal.c
       utils/StringIterator/StringIterator.c
       utils/debug.c
       # app/RadixApplication.c
       # app/RadixGTK.c
       WSLocal.c
       Main.c)

os=$(grep -oP '(?<=PRETTY_NAME=").*(?=")' /etc/os-release)
coreoptions=(-D_OS='"'"$os"'"' -lmicrohttpd -pthread -fPIE -lrt) # -D_VERSION="0.1"
arguments=()

mkdir -p out
mkdir -p out/assembler

for arg in "$@"; do
  if [[ "$arg" == "--assembler" ]]; then
    mkdir -p out/assembler
    echo -e "Generating assembler output...\n"
    for file in "${corec[@]}"; do
      echo "Compiling $file..."  
      gcc "$file" -S -masm=intel "${coreoptions[@]}" -o "out/assembler/${file##*/}.asm"
    done
    echo -e "\nAssembler output generated at out/assembler/core."
    exit
   fi 
done

echo gcc "${corec[@]}" "$@" "${coreoptions[@]}" -DUTIL_DEBUG_CMPL -o out/core
gcc "${corec[@]}" "$@" "${coreoptions[@]}" -DUTIL_DEBUG_CMPL -o out/core

# assemble html code
chmod +x ./html/build.sh
./html/build.sh
