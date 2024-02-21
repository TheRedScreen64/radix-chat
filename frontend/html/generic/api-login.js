/// TODO fill out using api methods

/*
 * returns true if email already belongs to an username
 */
function /* :bool */ api_email_present(email) {
    return false;
}

/*
 * returns true if username was already taken
 */
function /* :bool */ api_uname_present(uname) {
    return false;
}

/*
 * registers new user to the system api automatically grants a session cookie
 * returns false if data contains illegal/suspicius content (or script/html tags) and was blocked by the server
 * IP will be lifetime blocked from frontend service
 */
function /* :bool */ api_register_user(email, passwd, uname, real_name, persistent /* (remember user?) */) {
    return true;
}

/*
 * automatically grants a session cookie
 * returns false on invalid credentials 
 */
function /* :bool */ api_login_user(email, passwd, persistent) {
    return true;
}

/*
 * automatically grants a session cookie
 * returns false on invalid token 
 */
function /* :bool */ api_login_userWithGoogle(oAuthClientToken) {
    return true;
}