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
