#include "../../properties.h"

async function /* :JsonObject */ api_instanceLoggedIn() {
    const response = await fetch(CLIENT_BACKEND_API_URL + "/user", {
        method: "GET",
        credentials: "include" 
    });
    return await response.json();
}

async function api_logout() {
    const response = await fetch(CLIENT_BACKEND_API_URL + "/auth/logout", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        credentials: "include"
    });
    return await response.json();
}

async function /* :bool */ api_patch_user(email, uname, real_name, avatar_url) {
    const body = {
        email: email,
        username: uname,
        name: real_name,
        avatarUrl: avatar_url
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/user", {
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

async function /* :bool */ api_suggest_topic(title, description) {
    const body = {
        title: title,
        description: description,
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/topics", {
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

async function /* :JsonObject */ api_getTopics() {
    const response = await fetch(CLIENT_BACKEND_API_URL + "/topics", {
        method: "GET",
        credentials: "include" 
    });
    return await response.json();
}

async function /* :bool */ api_voteTopic(iD) {
    const body = {
        topicId: iD
    };

    const response = await fetch(CLIENT_BACKEND_API_URL + "/topic/vote", {
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

async function /* :JsonObject */  api_getTopic()
{
    const response = await fetch(CLIENT_BACKEND_API_URL + "/topic/today", {
        method: "GET",
        credentials: "include" 
    });
    return await response.json();
}

async function /* bool */ api_getMessages(lastId) 
{
    const url = new URL(CLIENT_BACKEND_API_URL + "/global/messages");
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