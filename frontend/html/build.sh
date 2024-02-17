# /usr/bin/bash 

# gcc arguments:
# -E: generate preproccessor output
# -x: ignore file extension css and mark file as c code
# -P: prevent generation of line markers
# -w: ignore warnings

mkdir -p assets

# login screen
gcc  -w -E -x c -P html/pages/login/index.html -o assets/login.html
# frame
gcc  -w -E -x c -P html/frame.h -o assets/frame.html
# loader 
gcc  -w -E -x c -P html/loader/index.html -o assets/loader.html
# 404 page 
gcc  -w -E -x c -P html/404.html -o assets/404.html