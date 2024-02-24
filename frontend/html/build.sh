# /usr/bin/bash 

# gcc arguments:
# -E: generate preproccessor output
# -x: ignore file extension css and mark file as c code
# -P: prevent generation of line markers
# -w: ignore warnings

mkdir -p assets
mkdir -p assets/scripts

# login screen
gcc  -w -E -x c -P html/pages/login/index.html -o assets/login.nosehad
gcc  -w -E -x c -P html/pages/login/login.js -o assets/scripts/login.js

# landing page
gcc  -w -E -x c -P html/pages/landing/index.html -o assets/landing.nosehad

# frame
gcc  -w -E -x c -P html/frame.h -o assets/frame.nosehad

# loader 
gcc  -w -E -x c -P html/loader/index.html -o assets/loader.nosehad

# 404 page 
gcc  -w -E -x c -P html/404.html -o assets/404.nosehad

# background image 
gcc  -w -E -x c -P html/background.svg -o assets/images/background.svg

# content managment
gcc  -w -E -x c -P html/generic/Content/cms.html -o assets/cms.nosehad

# message utility
gcc  -w -E -x c -P html/generic/message.js -o assets/scripts/message.js