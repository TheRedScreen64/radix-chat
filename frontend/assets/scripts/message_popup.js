const audio = new Audio("/static/sounds/new_message.mp3");
const msg_colors = ["#FFE74C", "#FCCA46", "#FE7F2D", "#F3C677", "#FFEE88", "#F4D06F", "#FF8811", "#FCD757", "#DF9A57", "#FFBF69", "#ECCE8E"];
let range;
let inbox;
function sendMsgSteve(text) {
    if (inbox.childNodes.length > 5)
        return;
    const fragment = range.createContextualFragment(`<div class="msg-steve-wrap msg-personal">
    <msg class="msg-steve-content">
        <div class="grid-wrap">
            <span class="msg-bot-tag">BOT</span>
            <span class="msg-steve-title">Steve ■ Now</span>
        </div>
        <p>${text}</p>
    </msg>
    <img class="msg-steve-sender" src="/static/images/steve_profile.jpeg">
</div>`);
    inbox.appendChild(fragment)
}
let previous = "";
cms_runOnStartup(() => {
    console.log("cms on startup message");
    inbox = document.getElementById('inbox');
    range = document.createRange();
    document.addEventListener('animationend', (event) => {
        if (event.animationName == "appear") {
            event.target.remove();
        }
    });
    document.addEventListener('animationstart', (event) => {
        if (event.animationName == "appear") {
            try {
                audio.play();
            }
            catch (exception) {
                console.log("Failed to play notification sound");
            }
        }
        else if (event.animationName == "pop-in") {
            console.log("popin");
            if (event.target.parentElement.classList.contains("msg-recieved")) {
                let color = msg_colors[Math.floor(Math.random() * msg_colors.length)];
                while (color == previous)
                    color = msg_colors[Math.floor(Math.random() * msg_colors.length)];
                console.log("New color: " + color);
                previous = color;
                event.target.style.background = "#ca6d4c";
            }
        }
    });
});
