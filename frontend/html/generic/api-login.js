/// TODO fill out using api methods
#include "../../properties.h"

/*
 * returns true if email already belongs to an username
 */
async function /* :bool */ api_email_present(email) {
    const body = {
        email: email
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/user/exists", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(body)
    });

    const data = await response.json();

    if (!response.ok)
        console.log(`Something happened when trying to do this ${await response.text()} - code ${response.status}.`);


    return data.exists;
}

/*
 * returns true if username was already taken
 */
async function /* :bool */ api_uname_present(uname) {
    const body = {
        username: uname
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/user/exists", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(body)
    });

    const data = await response.json();

    if (!response.ok)
        console.log(`Something happened when trying to do this ${await response.text()} - code ${response.status}.`);

    return data.exists;
}

/*
 * registers new user to the system api automatically grants a session cookie
 */
async function /* :bool */ api_register_user(email, passwd, uname, real_name, persistent /* (remember user?) */) {
    const body = {
        email: email,
        password: passwd,
        username: uname,
        name: real_name,
        persistent: persistent
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/auth/signup", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(body),
        credentials: "include"
    });

    if (!response.ok) {
        console.log(`Something happened when trying to do this ${await response.text()} - code ${response.status}.`);
        return false;
    }

    return true;
}

/*
 * automatically grants a session cookie
 * returns false on invalid credentials 
 */
async function /* :bool */ api_login_user(email, passwd, persistent) {
    const body = {
        email: email,
        password: passwd,
        persistent: persistent
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/auth/login", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(body),
        credentials: "include"
    });

    console.log("headers: " + response.headers);


    console.log("setcookie header: " + response.headers.getSetCookie());

    if (!response.ok) {
        console.log(`Something happened when trying to do this ${await response.text()} - code ${response.status}.`);
        return false;
    }

    return true;
}

/*
 * automatically grants a session cookie
 * returns false on invalid token 
 */
async function /* :bool */ api_login_userWithGoogle(oAuthClientToken) {
    return true;
}