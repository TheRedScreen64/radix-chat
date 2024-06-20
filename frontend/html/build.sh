# /usr/bin/bash 

# gcc arguments:
# -E: generate preproccessor output
# -x: ignore file extension css and mark file as c code
# -P: prevent generation of line markers
# -w: ignore warnings

mkdir -p assets
mkdir -p assets/scripts

# api functions 
gcc  -w -E -x c -P html/generic/api-generic.js -o assets/scripts/api-generic.js

# login screen
gcc  -w -E -x c -P html/pages/login/index.html -o assets/login.nosehad
gcc  -w -E -x c -P html/pages/login/login.js -o assets/scripts/login.js

# chat page
gcc  -w -E -x c -P html/pages/chat/index.html -o assets/chat.nosehad
gcc  -w -E -x c -P html/pages/chat/chat.js -o assets/scripts/chat.js

# legal fun pages
gcc  -w -E -x c -P html/pages/info/about.html -o assets/about.nosehad
gcc  -w -E -x c -P html/pages/info/cookie_policy.html -o assets/cookie_policy.nosehad
gcc  -w -E -x c -P html/pages/info/imprint.html -o assets/imprint.nosehad
gcc  -w -E -x c -P html/pages/info/privacy_policy.html -o assets/privacy_policy.nosehad

# landing page
gcc  -w -E -x c -P html/pages/landing/index.html -o assets/landing.nosehad

# loader 
gcc  -w -E -x c -P html/loader/index.html -o assets/loader.nosehad

# 404 page 
gcc  -w -E -x c -P html/404.html -o assets/404.nosehad

# background image 
gcc  -w -E -x c -P html/background.svg -o assets/images/background.svg

# content managment
gcc  -w -E -x c -P html/generic/Content/cms.html -o assets/cms.nosehad

# message utility
gcc  -w -E -x c -P html/generic/message_popup.js -o assets/scripts/message_popup.js

# label utility
gcc  -w -E -x c -P html/generic/label.js -o assets/scripts/label.js