async function api_instanceLoggedIn() {
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/user", {
        method: "GET",
        credentials: "include"
    });
    return await response.json();
}
async function api_logout() {
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/auth/logout", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        credentials: "include"
    });
    return await response.json();
}
async function api_patch_user(email, uname, real_name, avatar_url) {
    const body = {
        email: email,
        username: uname,
        name: real_name,
        avatarUrl: avatar_url
    };
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/user", {
        method: "PATCH",
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
async function api_suggest_topic(title, description) {
    const body = {
        title: title,
        description: description,
    };
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/topics", {
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
async function api_getTopics() {
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/topics", {
        method: "GET",
        credentials: "include"
    });
    return await response.json();
}
async function api_voteTopic(iD) {
    const body = {
        topicId: iD
    };
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/topic/vote", {
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
async function api_getTopic()
{
    const response = await fetch("https://radix-api.theredscreen.com:3000" + "/topic/today", {
        method: "GET",
        credentials: "include"
    });
    return await response.json();
}
async function api_getMessages(lastId)
{
    const url = new URL("https://radix-api.theredscreen.com:3000" + "/global/messages");
    url.searchParams.append("lastId", lastId);
    const response = await fetch(url, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        },
        credentials: "include"
    });
    return await response.json();
}
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
    msgWebsocket = new WebSocket("wss://radix-api.theredscreen.com:3000");
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
            if (lastMessageLoaded != undefined) {
                lastMessageLoaded.querySelector("msg").querySelectorAll(':scope > p').forEach(text => {
                    msg_input.value += text.innerText;
                });
                lastMessageLoaded.style.display = "none";
            }
        }
        if (Object.hasOwn(parsed, "type")) {
            switch (parsed.type) {
                case "globalMessage":
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
let uname_inp, real_name_inp, avatar_inp, email_inp, file_inp, avatar;
async function setupSettings() {
    uname_inp = document.getElementById("uname");
    real_name_inp = document.getElementById("real_name");
    avatar_inp = document.getElementById("avatar");
    email_inp = document.getElementById("mail");
    file_inp = document.getElementById("avatar");
    uname_inp.value = userdata['username'];
    real_name_inp.value = userdata['name'];
    email_inp.value = userdata['email'];
    let avatarHTML = userdata['avatarUrl'] == undefined ?
        `<div class="avatar-preview"><name>${userdata['username'][0].toUpperCase()}${userdata['username'][1] ? userdata['username'][1].toUpperCase() : ''}</name></div>` :
        `<img class="avatar-preview" src="${userdata['avatarUrl']}">`;
    document.getElementById("avatar-wrap").innerHTML = avatarHTML;
    file_inp.addEventListener('change', async (event) => {
        const file = event.target.files[0];
        if (!file) {
            return;
        }
        if(!file.name.endsWith(".png") && !file.name.endsWith(".jpeg") && !file.name.endsWith(".jpg") && !file.name.endsWith(".jpeg") && !file.name.endsWith(".webp"))
        {
            sendMsgSteve("You can only use an image as profile picture😉");
            return;
        }
        const url = `/content/push/${userdata['username']}/${(new Date()).toISOString()}/${encodeURIComponent(file.name)}`.replace(" ", "_");
        avatar = "https://"+"development.nosehad.com" + url.replace("/push/", "/get/");
        try {
            const response = await fetch(url, {
                method: 'POST',
                body: file,
                headers: {
                    'Content-Type': 'application/octet-stream'
                }
            });
            if (response.ok) {
                console.log('Image uploaded successfully:', response);
            } else {
                console.error('Image upload failed:', response.statusText);
            }
        } catch (error) {
            console.error('Error during Image upload:', error);
        }
        document.getElementById("avatar-wrap").innerHTML = `<img class="avatar-preview" src="${avatar}">`;
    });
}
async function logout() {
    api_logout();
    sendMsgSteve("Good bye ma'am👋");
    setTimeout(() => window.location.replace("/login"), 2000)
}
async function saveChanges() {
    let res = await api_patch_user(email_inp.value, uname_inp.value, real_name_inp.value, avatar);
    if (res) {
        sendMsgSteve("Your Details were updated👌");
        userdata['username'] = uname_inp.value;
    }
    else
        sendMsgSteve("Slow down, Cowboy🧐");
}
let question_inp, description_inp, resource_inp;
let confirmation_backdrop, confirmation_container;
let topics, topic_list;
let currentTopicId;
async function setupTopics() {
    question_inp = document.getElementById("question");
    description_inp = document.getElementById("desc");
    confirmation_backdrop = document.querySelector(".proposal-confirmation-backdrop");
    confirmation_container = document.querySelector(".proposal-confirmation-wrap");
    topics = await api_getTopics();
    topic_list = document.querySelector(".topic-list");
    topic_list.innerHTML = ""
    topics.forEach(topic => {
        let li = document.createElement("li")
        let container = document.createElement("div")
        container.className = "top"
        let span = document.createElement("span")
        span.innerText = topic.title
        let md_converter = new showdown.Converter();
        let content = md_converter.makeHtml(topic.description);
        let desc = document.createElement("div")
        desc.className = "desc"
        desc.innerHTML = content
        let button = document.createElement("button")
        button.addEventListener("click", () => { voteTopic(topic.id) })
        button.innerText = `Vote (${topic.votes})`
        container.appendChild(span)
        container.appendChild(button)
        let hr = document.createElement("hr")
        li.appendChild(container)
        li.appendChild(desc)
        topic_list.appendChild(li)
        if (topics.indexOf(topic) < (topics.length - 1)) {
         topic_list.appendChild(hr)
        }
    });
    let todays_topic = await api_getTopic();
    console.log(todays_topic)
    let title = todays_topic["title"];
    if (title != undefined) {
        document.getElementById("topic-title").innerHTML = todays_topic["title"];
        let truncatedText = todays_topic["description"].substring(0, 100) + "..."
        const textElement = document.getElementById("topic-desc")
        let readMore = document.createElement("a")
        if (todays_topic["description"].length > 100) {
          textElement.innerHTML = truncatedText;
          textElement.classList.add('shortened');
        } else {
          textElement.innerHTML = todays_topic["description"];
          readMore.style.display = 'none';
        }
        readMore.addEventListener("click", () => {
         if (textElement.innerText === truncatedText) {
            textElement.innerText = todays_topic["description"];
            textElement.classList.remove('shortened');
            readMore.innerText = 'Read Less';
          } else {
            textElement.innerText = truncatedText;
            textElement.classList.add('shortened');
            readMore.innerText = 'Read More';
          }
        })
        readMore.innerText = "Read More"
        document.getElementById("chat-header").appendChild(readMore)
    } else {
      document.getElementById("topic-title").innerHTML = "Fun Chat";
      document.getElementById("topic-desc").innerHTML = "Talk about things which are currently occupying you.";
    }
}
function submitTopic() {
    if (question_inp.value.length < 5) {
        sendMsgSteve("Ask a question.");
        return;
    }
    else if (description_inp.value.length < 10) {
        sendMsgSteve("Give a description.");
        return;
    }
    if (question_inp.value.length > 53) {
        sendMsgSteve("Please ensure that your question contains less than 50 characters.");
        return;
    }
    else if (description_inp.value.length > 205) {
        sendMsgSteve("Please ensure that your question contains less than 200 characters.");
        return;
    }
    confirmation_backdrop.style.display = "flex";
    confirmation_backdrop.style.backdropFilter = "blur(8px)";
    confirmation_container.style.opacity = "1";
    confirmation_container.style.display = "block";
    confirmation_container.style.zIndex = "3";
    document.getElementById("proposal-recap").innerHTML = `<strong>${question_inp.value}</strong><br>${description_inp.value})`
}
function cancelProposal() {
    confirmation_backdrop.style.display = "none";
    confirmation_backdrop.style.backdropFilter = "none";
    confirmation_container.style.opacity = "0";
    confirmation_container.style.display = "none";
    confirmation_container.style.zIndex = "-1";
}
async function makeProposal() {
    confirmation_backdrop.style.display = "none";
    confirmation_backdrop.style.backdropFilter = "none";
    confirmation_container.style.opacity = "0";
    confirmation_container.style.display = "none";
    confirmation_container.style.zIndex = "-1";
    let status = await api_suggest_topic(question_inp.value, `${description_inp.value}`);
    if (status) {
        sendMsgSteve(`Successfully proposed your topic`);
    }
    else {
        sendMsgSteve(`You have already suggested a topic today`);
    }
    setupTopics()
}
async function voteTopic(topicId) {
   let status = await api_voteTopic(topicId);
   if (status) {
      sendMsgSteve(`Successfully voted for topic`);
  }
  else {
      sendMsgSteve(`You have already voted for this topic`);
  }
  setupTopics()
}
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
            msg_input.style.borderLeft = `2px solid #a29d99`;
            msg_input.style.borderRight = `2px solid #a29d99`;
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
