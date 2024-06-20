#include "../../colortheme.h"

#include "../../generic/api-generic.js"

#include "chatutility.js"

#include "settings.js"

#include "topic.js"

let userdata, msg_input, chat_input, msg_input_buttons;
let body_sections, nav_links;
let lastMessageSent;

async function postSetup() {
    userdata = await api_instanceLoggedIn();
    console.log("logged in (chat): " + JSON.stringify(userdata));
    userdata['avatarUrl']
    if (userdata['error'] != undefined) {
        userdata = undefined;
        redirect("/login");
    }
    else {
        setupSettings();
        setupChatUtility();
        setupTopics();
    }
}

async function sendMessage() {
    lastMessageSent = await spawnMessage(userdata['username'], new Date(), userdata["avatarUrl"], msg_input.value, true, false)
    setTimeout(() => {
        lastMessageSent.scrollIntoView({ behavior: "smooth", block: "end", inline: "nearest" });
    }, 200)
    msgWebsocket.send(JSON.stringify({
        "type": "globalMessage",
        "data": {
           "content": msg_input.value
        }}));

    msg_input.placeholder = "Whatever";
    msg_input.value = "";
    msg_input.style.height = 'auto';
    let svgl = document.getElementById("svg-l");
    let svgr = document.getElementById("svg-r");

    svgl.style.animation = "svg-l-fade-out 0.3s 1 ease-out";
    svgl.style.opacity = "1";
    svgl.style.width = "auto";
    svgl.style.border = "2px solid #a29d99";
    svgl.style.padding = "12px";

    svgr.style.animation = "svg-r-fade-out 0.3s 1 ease-out";
    svgr.style.opacity = "1";
    svgr.style.width = "auto";
    svgr.style.border = "2px solid #a29d99";
    svgr.style.padding = "12px";

    msg_input_buttons.style.display = "none";

    msg_input.style.borderLeft = "none";
    msg_input.style.borderRight = "none";
    msg_input.style.borderRadius = "0px";

    msg_input.style.minWidth = `0px`;
}

function resetInput() {

}

cms_runOnStartup(() => {
    msg_input = document.getElementById("msg-input");
    chat_input = document.getElementById("chat-input");
    msg_input_buttons = document.getElementById("msg-input-buttons");
    body_sections = document.querySelectorAll('section');
    nav_links = document.querySelectorAll('nav a');
    let input_used = false;

    /* send init message */
    const initMessage = cms_getAndPopQueryValue("initMessage");

    if (initMessage != undefined) {
        setTimeout(() => {
            sendMsgSteve(initMessage);
            console.log("Send Message: " + initMessage)
        }, 1000);
    }

    msg_input.addEventListener("input", () => {
        msg_input.style.height = 'auto';
        msg_input.style.height = Math.min(msg_input.scrollHeight - 20, 200) + "px";
        if (msg_input.value == "") {
            let svgl = document.getElementById("svg-l");
            let svgr = document.getElementById("svg-r");

            svgl.style.animation = "svg-l-fade-out 0.3s 1 ease-out";
            svgl.style.opacity = "1";
            svgl.style.width = "auto";
            svgl.style.border = "2px solid #a29d99";
            svgl.style.padding = "12px";

            svgr.style.animation = "svg-r-fade-out 0.3s 1 ease-out";
            svgr.style.opacity = "1";
            svgr.style.width = "auto";
            svgr.style.border = "2px solid #a29d99";
            svgr.style.padding = "12px";

            msg_input_buttons.style.display = "none";

            msg_input.style.borderLeft = "none";
            msg_input.style.borderRight = "none";
            msg_input.style.borderRadius = "0px";

            msg_input.style.minWidth = `0px`;
        }
    })

    msg_input.addEventListener("keypress", (event) => {
        if (event.key == "Enter") {
         if (event.shiftKey) {
            event.preventDefault()
            sendMessage()
         } 
        }
      //   if (event.key == "Backspace") {
      //    if (rows-- < 10)
      //       msg_input.setAttribute("rows", rows)
      //   }

        if (!input_used) {
            let svgl = document.getElementById("svg-l");
            let svgr = document.getElementById("svg-r");

            svgl.style.animation = "svg-l-fade-out 0.3s 1 ease-out";
            svgl.style.opacity = "0";
            svgl.style.width = "0";
            svgl.style.border = "none";
            svgl.style.padding = "0";

            svgr.style.animation = "svg-r-fade-out 0.3s 1 ease-out";
            svgr.style.opacity = "0";
            svgr.style.width = "0";
            svgr.style.border = "none";
            svgr.style.padding = "0";

            msg_input_buttons.style.display = "flex";

            msg_input.style.borderLeft = `2px solid PRIMARY_BG_2`;
            msg_input.style.borderRight = `2px solid PRIMARY_BG_2`;
            msg_input.style.borderRadius = "5px";

            msg_input.style.minWidth = `${chat_input.offsetWidth - 40}px`;
        }

        console.log("value: " + msg_input.value + " check: " + msg_input.value == "");
    })

    postSetup();
});

function switchSection(id) {
    body_sections.forEach(element => {
        if(element.id == id)
            element.classList.add('active');
        else
            element.classList.remove('active');
    });
    nav_links.forEach(link => {
        if(link.id.endsWith(id))
            link.classList.add('active');
        else
            link.classList.remove('active');
    });
}