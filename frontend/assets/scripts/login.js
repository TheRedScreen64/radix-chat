function api_email_present(email) {
    return false;
}
function api_uname_present(uname) {
    return false;
}
function api_register_user(email, passwd, uname, real_name, persistent ) {
    return true;
}
function api_login_user(email, passwd, persistent) {
    return true;
}
function api_login_userWithGoogle(oAuthClientToken) {
    return true;
}
const bg_color = `#E4DFDA`;
const range = document.createRange();
const email_regex = /[-A-Za-z0-9!#$%&'*+/=?^_`{|}~]+(?:\.[-A-Za-z0-9!#$%&'*+/=?^_`{|}~]+)*@(?:[A-Za-z0-9](?:[-A-Za-z0-9]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[-A-Za-z0-9]*[A-Za-z0-9])?/;
const user_regex = /([A-Za-z0-9]+(_[A-Za-z0-9]+)+)/
let inbox, emailInp, passwdInp, confirmPasswdInp,
    rememberUser, usernameInp, realnameInp, cookieInp, signUpStage;
function sendMsgSteve(text) {
    if (inbox.childNodes.length > 5)
        return;
    const fragment = range.createContextualFragment(`<div class="msg-wrap">
    <msg class="msg-content">
        <div class="grid-wrap">
            <span class="msg-title">Steve ■ Now</span>
        </div>
        ${text}
    </msg>
    <img class="msg-sender" src="/static/images/steve_profile.jpeg">
</div>`);
    inbox.appendChild(fragment)
}
function signUp() {
    switch (signUpStage) {
        case 0:
            signUp_doStage1();
            return;
        case 1:
            signUp_doStage2();
            return;
        case 2:
            signUp_doStage3();
            return;
        case 3:
            signUp_doStage4();
            return;
    }
    if (confirmPasswdInp.value == "") {
        return;
    }
    else if (usernameInp.value == "") {
        sendMsgSteve("Now tell me how you would like to be called.");
        return;
    }
    else if (real_name.value == "") {
        sendMsgSteve("I also need to know your real name🧐");
        return;
    }
}
function signUp_doStage1() {
    if (emailInp.value == "" || !email_regex.test(emailInp.value) ) {
        emailInp.classList.add("invalid");
        sendMsgSteve("Please enter a correct email address😉");
        return;
    }
    else if (passwdInp.value.length < 10 ) {
        passwdInp.classList.add("invalid");
        sendMsgSteve("Enter a password with at least 10 characters😉");
        return;
    }
    sendMsgSteve("Oh I didn't notice you are new here😅<br> Please confirm your password.");
    if (api_email_present(emailInp.value)) {
        if (api_login_user(emailInp.value, passwdInp.value, rememberUser.checked)) {
            window.location.replace('/');
        } else {
            passwdInp.classList.add("invalid");
            sendMsgSteve("The password is incorrect🤔");
        }
        return;
    }
    signUpStage++;
    hideAdditional();
    emailInp.style.display = 'none';
    passwdInp.style.display = 'none';
    confirmPasswdInp.style.display = 'block';
    document.getElementById('signup-text').innerHTML = 'Next →';
}
function signUp_doStage2() {
    if (passwdInp.value != confirmPasswdInp.value) {
        confirmPasswdInp.classList.add("invalid");
        sendMsgSteve("Are you sure? For me it looks like that wasn't the password you previously entered😉");
        return;
    }
    signUpStage++;
    confirmPasswdInp.style.display = 'none';
    usernameInp.style.display = 'block';
    real_name.style.display = 'block';
    sendMsgSteve("You are almost done, just give me some info about you🤏");
}
function signUp_doStage3() {
    if (usernameInp.value == "") {
        usernameInp.classList.add("invalid");
        sendMsgSteve("Do you think I am stupid🙄<br> I don't allow empty user names.<br>Do I have to <a onclick='generateRandomUname()'>create one Random</a>?");
        return;
    }
    else if (user_regex.test(usernameInp.value)) {
        usernameInp.classList.add("invalid");
        sendMsgSteve("Bro just use lower case number and letters💀 or <a onclick='generateRandomUname()'>create one Random</a>");
        return;
    }
    else if (api_uname_present(usernameInp.value)) {
        usernameInp.classList.add("invalid");
        sendMsgSteve("Oh seems like this usernameInp is already taken🫤<br> Think of something else, or<br><a onclick='generateRandomUname()'>create one Random</a>");
        return;
    }
    else if (usernameInp.value.toLowerCase().includes("kaiss")) {
        localStorage.setItem("kaiss", "true");
        cms_runOnStartup(() => {
            setInterval(() => {
                sendMsgSteve("Du kannst nicht chatten während dem du durch den Raum rollst<br><img src='/static/images/kaiss.png' style='width: 420px;'>");
            }, 5000);
        });
    }
    if (realnameInp.value == "") {
        realnameInp.classList.add("invalid");
        sendMsgSteve("Do you think I am stupid🙄<br> Everybody has a name.");
        return;
    }
    signUpStage++;
    usernameInp.style.display = 'none';
    real_name.style.display = 'none';
    document.getElementById('signup-text').innerHTML = '<strong>Sign Up<strong>';
    document.getElementById("cookie-wrap1").style.display = "grid";
    document.getElementById("cookie-wrap2").style.display = "grid";
    sendMsgSteve("I need to ask you something about cookies.. 🍪");
}
function signUp_doStage4() {
    if (!cookieInp.checked) {
        sendMsgSteve("I am sorry, but it's not possible to consume the platform without eating some of those delicious cookies😋");
        return;
    }
    api_register_user(emailInp.value, passwdInp.value, usernameInp.value, realnameInp.value, rememberUser.value);
    redirect('/');
}
function hideAdditional() {
    Array.from(document.getElementsByClassName("login-additional")).forEach(element => {
        element.style.display = "none";
    });
}
function generateRandomUname() {
    if (usernameInp.classList.contains("invalid"))
        usernameInp.classList.remove("invalid")
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (xhttp.readyState === 4 && xhttp.status === 200) {
            let names = JSON.parse(xhttp.responseText);
            let name = names[Math.floor(Math.random() * names.length)];
            usernameInp.value = name;
            sendMsgSteve(`Would you like to be called <strong style='color:${bg_color}'>${name}</strong><br> or do you want me to <a onclick='generateRandomUname()'>try again</a>?`);
        }
    }
    xhttp.open("GET", "/static/json/animal-names.json", true);
    xhttp.send();
}
cms_runOnStartup(() => {
    inbox = document.getElementById('inbox');
    emailInp = document.getElementById("email");
    passwdInp = document.getElementById("password");
    confirmPasswdInp = document.getElementById("confirm_password");
    rememberUser = document.getElementById("remember");
    usernameInp = document.getElementById("uname");
    realnameInp = document.getElementById("real_name");
    cookieInp = document.getElementById("cookies");
    signUpStage = 0;
    if (localStorage.getItem("kaiss") != undefined) {
        cms_runOnStartup(() => {
            setInterval(() => {
                sendMsgSteve("Du kannst nicht chatten während dem du durch den Raum rollst<br><img src='/static/images/kaiss.png' style='width: 420px;'>");
            }, 5000);
        });
    }
    setTimeout(() => {
        sendMsgSteve("Hey Boss 👋<br>Please sign in to continue.");
    }, 1000);
    document.addEventListener("keypress", (event) => {
        if (event.key == "Enter")
            signUp();
    });
});
