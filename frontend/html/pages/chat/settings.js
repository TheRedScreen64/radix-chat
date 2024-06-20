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

    /* avatar preview */
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
        avatar = SRV_URL_COMPLETE + url.replace("/push/", "/get/");

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
        userdata['username'] = uname_inp.value; /* change to render messages correctly*/
    }
    else
        sendMsgSteve("Slow down, Cowboy🧐");
}