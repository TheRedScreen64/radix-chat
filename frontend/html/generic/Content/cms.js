let cms_pages = C_PRELOAD_CONST_PAGES;

let cms_ov_responseText;
let cms_ov_modifyer;
let cms_init_body;
let cms_current_location;
let cms_document_cache = new Map();
let cms_startup_cache = new Map();
let cms_loaded_scripts = new Map();

function cms_loadScript(uri) {
    if (cms_loaded_scripts.get(uri)) /* prevent script redeclaration */
        return;

    cms_loaded_scripts.set(uri, true);

    let scriptElement = document.createElement('script');
    scriptElement.src = uri;
    scriptElement.setAttribute("charset", 'UTF-8');
    document.head.appendChild(scriptElement);
}

function cms_runOnStartup(func) {
    let startup_handlers = cms_startup_cache.get(cms_current_location);

    if (startup_handlers == undefined) {
        startup_handlers = new Set();
        cms_startup_cache.set(cms_current_location, startup_handlers);
    }

    startup_handlers.add(func); /* add startup handler for ducment */

    func(); /* call function */
}

function cms_pushContent() {
    if (cms_init_body == undefined)
        cms_init_body = document.body.cloneNode(true);

    cms_ov_modifyer = () => {
        document.open();
        document.write(cms_ov_responseText);

        /* register popstate after document.write */
        window.addEventListener('popstate', function (event) {
            redirect(window.location.pathname, true, false);
        });

        if (cms_document_cache.get(cms_current_location) == undefined)
            cms_document_cache.set(cms_current_location, cms_ov_responseText);

        /* call startup handlers */
        let handlers = cms_startup_cache.get(cms_current_location);
        if (handlers != undefined) {
            handlers.forEach(handler => {
                handler();
            });
        }

        cms_ov_modifyer = undefined;
        cms_ov_responseText = undefined;
    }
    if (cms_ov_responseText != undefined)
        cms_ov_modifyer();
}

function redirect(rlocation, r = true, ps = true) {
    if (r)
        document.documentElement.replaceWith(cms_init_body);

    if (ps)
        history.pushState(null, '', rlocation);

    cms_current_location = rlocation;

    document.addEventListener('animationend', (event) => {
        if (event.animationName == "content-fade") {
            cms_pushContent()
        }
    });

    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (xhttp.readyState === 4 && xhttp.status === 200) {
            cms_ov_responseText = xhttp.responseText;
            if (cms_ov_modifyer != undefined)
                cms_ov_modifyer();
        }
    }

    cms_ov_responseText = cms_document_cache.get(rlocation);

    if (cms_ov_responseText != undefined)
        return;
    else if (rlocation.endsWith('login')) {
        xhttp.open("GET", "/static/login.nosehad", true);
    }
    else {
        xhttp.open("GET", "/static/landing.nosehad", true);
    }

    xhttp.send();
}

redirect(window.location.pathname, false);