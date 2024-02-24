const audio = new Audio("/static/sounds/new_message.mp3");
cms_runOnStartup(() => {
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
    });
});
