//#define RADIX_MAKE_APP
#define PORT 443
#define PORT_S "443"

#define SRV_URL "development.nosehad.com"
#define SRV_URL_COMPLETE "https://"+SRV_URL
#define SRV_USE_HTTPS 1
#define SRV_TLS_CERT "/etc/letsencrypt/live/development.nosehad.com/fullchain.pem"
#define SRV_TLS_KEY "/etc/letsencrypt/live/development.nosehad.com/privkey.pem"

#define SRV_PREFIX "[\e[36m\e[1mSERV-LOCAL\e[0m] "
#define SRV_STATIC_DIR "./assets/"
#define SRV_BUILD_DIR "./html"
#define SRV_404_TEMPLATE "./assets/404.nosehad"
#define SRV_404_ROUTE "/static/404.nosehad"
#define SRV_DEF_TEMPLATE "./assets/cms.nosehad"

#define SRV_PAGE_CONFIG "./assets/json/pages-config.json"

#define SRV_USEDEBUGMODE 2024 /* enable outomatic recompile on file change */

#define CLIENT_BACKEND_API_URL "https://radix-api.theredscreen.com:3000"
#define CLIENT_WEBSOCKET_URL "wss://radix-api.theredscreen.com:3000"