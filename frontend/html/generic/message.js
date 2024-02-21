/* message sound */
const audio = new Audio("/static/sounds/new_message.mp3");

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
        catch(exception) {
            /// TODO: print message to allow sounds (ask for permission)
            console.log("Failed to play notification sound");
        }
    }
});