/* message sound */
const audio = new Audio("/static/sounds/new_message.mp3");

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

cms_runOnStartup(() => {
    /* animated inbox */
    document.addEventListener('animationend', (event) => {
        if (event.animationName == "appear") {
            event.target.remove();
        }
    });

    //document.body.style.animationDuration
    document.addEventListener('animationstart', (event) => {
        if (event.animationName == "appear") {
            //event.target.style.animationDuration = ""
            try {
                audio.play();
            }
            catch (exception) {
                /// TODO: print message to allow sounds (ask for permission)
                console.log("Failed to play notification sound");
            }
        }
    });
});