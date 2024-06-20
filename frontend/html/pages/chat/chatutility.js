#include "../../../properties.h"

let msgContainer, msgScrollContainer;
let lastMessageLoaded;
let msgLastLoaded;
let msgWebsocket;
let currentMsgDate;

function getTimeString(date) {
    const now = date;
    const hours = now.getHours();
    const minutes = now.getMinutes().toString().padStart(2, '0');
    return hours + ':' + minutes;
}

function getDateString(date) {
    const dateObject = new Date(date);

    const day = dateObject.getUTCDate();
    /* get ordinal suffix */
    let dayWithSuffix;
    if (day > 10 && day < 20) dayWithSuffix = `${day}th`;
    else
        switch (day % 10) {
            case 1: dayWithSuffix = `${day}st`; break;
            case 2: dayWithSuffix = `${day}nd`; break;
            case 3: dayWithSuffix = `${day}rd`; break;
            default: dayWithSuffix = `${day}th`; break;
        }

    const monthNames = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];

    return `${dayWithSuffix} ${monthNames[dateObject.getUTCMonth()]} ${dateObject.getUTCFullYear()}`;
}

async function spawnMessage(sender, time, avatarUrl, md_content, selfsent, bottag = false) {
    let msgDate = getDateString(time);
    if (currentMsgDate != msgDate) {
        msgContainer.appendChild(range.createContextualFragment(`<div class="chat-info"><p>${msgDate}</p></div>`));
        currentMsgDate = msgDate;
    }


    var md_converter = new showdown.Converter(),
        content = md_converter.makeHtml(md_content);
    let fragmentHTML = `<msg class="msg-content">
        <div class="grid-wrap">
            ${bottag ? "<span class=\"msg-bot-tag\">BOT</span>" : ""}
            <span class="msg-title">${sender} ■ ${getTimeString(time)}</span>
        </div>
        ${content}
    </msg>`;
    let avatarHTML = (avatarUrl == undefined ?
        `<div class="msg-sender"><name>${sender[0].toUpperCase()}${sender[1] ? sender[1].toUpperCase() : ''}</name></div>` :
        `<img class="msg-sender" src="${avatarUrl}">`);

    if (selfsent)
        fragmentHTML = fragmentHTML + avatarHTML;
    else
        fragmentHTML = avatarHTML + fragmentHTML;


    const fragmentId = `${Math.random()}`;
    const fragment = range.createContextualFragment(`<div id="${fragmentId}" class="msg-wrap ${selfsent ? "msg-personal" : "msg-recieved"}">${fragmentHTML}</div>`);
    await msgContainer.appendChild(fragment);
    const fragmentElement = document.getElementById(fragmentId);
    return fragmentElement;
}

function onIntersection(entries, observer) {
    entries.forEach(async (entry) => {
        if (entry.isIntersecting) {
            try {
                const messages = await api_getMessages(lastMessageLoaded) ;
                if (messages.length > 0) {
                    let msgsToLoad = Array.from(messages).reverse();
                    lastMessageLoaded = msgsToLoad[msgsToLoad.length - 1].id;
                    let msgScrollTo;
                    for (let message of msgsToLoad) {
                        msgScrollTo = await spawnMessage(
                            message['user']['username'],
                            new Date(message['postedAt']),
                            message['user']['avatarUrl'],
                            message['content'],
                            message['user']['username'] == userdata['username'],
                            false
                        );
                    }

                    setTimeout(() => {
                        msgScrollTo.scrollIntoView({ behavior: "smooth", block: "end", inline: "nearest" });

                        //observer.observe(msgScrollContainer);
                    }, 200);
                } else {
                    observer.unobserve(entry.target);
                }
            } catch (error) {
                console.error('Error loading messages:', error);
            }

            observer.unobserve(entry.target);
        }
    });
}

async function loadMessages() {
    const observer = new IntersectionObserver(onIntersection, {
        root: null,
        rootMargin: '0px',
        threshold: [0]
    });

    observer.observe(msgScrollContainer);
}

async function establishWebsocket() {
    console.log("establishing websocket...");

    msgWebsocket = new WebSocket(CLIENT_WEBSOCKET_URL);

    msgWebsocket.onerror = (error) => {
        console.log("error: " + error);
    }

    msgWebsocket.onmessage = async ({ data }) => {
        parsed = JSON.parse(data);
        if (parsed['error'] != undefined) {
            if (Object.hasOwn(parsed['error'], "errors")) {
                sendMsgSteve(parsed['error'].message + ": " + JSON.stringify(parsed['error'].errors));
            } else {
                sendMsgSteve(parsed['error'].message);
            }
            if (lastMessageLoaded != undefined) { /* respawn message text into chat input */
                lastMessageLoaded.querySelector("msg").querySelectorAll(':scope > p').forEach(text => {
                    msg_input.value += text.innerText;
                });
                lastMessageLoaded.style.display = "none";
            }
        }
        if (Object.hasOwn(parsed, "type")) {
            switch (parsed.type) {
                case "globalMessage":
                    // console.log(data)
                    console.log(userdata['username'])
                    let selfsent = userdata['username'] == parsed.message.user.username
                    let message = await spawnMessage(parsed.message.user.username, new Date(parsed.message.postedAt), parsed.message.user.avatarUrl, parsed.message.content, selfsent)
                    setTimeout(() => {
                        message.scrollIntoView({ behavior: "smooth", block: "end", inline: "nearest" });
                    }, 200);
            }
        }
        console.log(`Received message: ${data}`);
    };
}

async function setupChatUtility() {
    msgContainer = document.getElementById("msg-storage");
    msgScrollContainer = document.getElementById("chat-wrap");
    msgContainer.innerHTML = "";

    loadMessages();
    establishWebsocket();
}