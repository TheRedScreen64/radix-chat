#include "../../colortheme.h"

cms_runOnStartup(() => {
    const msg_input = document.getElementById("msg-input");
    const chat_input = document.getElementById("chat-input");
    const msg_input_buttons = document.getElementById("msg-input-buttons");
    let rows = 1;
    let input_used = false;

    msg_input.addEventListener("input", ()=> {
        if(msg_input.value == "")
        {
            let svgl = document.getElementById("svg-l");
            let svgr = document.getElementById("svg-r");

            svgl.style.animation = "svg-l-fade-out 0.3s 1 ease-out";
            svgl.style.opacity = "1";

            svgr.style.animation = "svg-r-fade-out 0.3s 1 ease-out";
            svgr.style.opacity = "1";

            msg_input_buttons.style.display  = "none";

            msg_input.style.borderLeft = "none";
            msg_input.style.borderRight = "none";
            msg_input.style.borderRadius = "0px";

            msg_input.style.minWidth = `0px`;

            /* reset rows */
            msg_input.setAttribute("rows", 1)
            rows = 1;
        }
    })

    msg_input.addEventListener("keypress", (event) => {
        if (event.key == "Enter") {
            if (rows++ < 10)
                msg_input.setAttribute("rows", rows)
        }

        if (!input_used) {
            let svgl = document.getElementById("svg-l");
            let svgr = document.getElementById("svg-r");

            svgl.style.animation = "svg-l-fade-out 0.3s 1 ease-out";
            svgl.style.opacity = "0";

            svgr.style.animation = "svg-r-fade-out 0.3s 1 ease-out";
            svgr.style.opacity = "0";

            msg_input_buttons.style.display  = "block";

            msg_input.style.borderLeft = `2px solid SECONDARY_BG`;
            msg_input.style.borderRight = `2px solid SECONDARY_BG`;
            msg_input.style.borderRadius = "5px";

            msg_input.style.minWidth = `${chat_input.offsetWidth - 40}px`;
        }

        console.log("value: " + msg_input.value + " check: " + msg_input.value == "");
    })
});