cms_runOnStartup(() => {
    document.querySelectorAll("[hover-label]").forEach((element) => {
        element.addEventListener("mouseover", () => {
            const label = document.createElement('span');
            label.classList.add('hover-label');
            label.textContent = element.getAttribute("hover-label");
            const rect = element.getBoundingClientRect();
            label.style.left = `${rect.left + window.scrollX}px`;
            label.style.top = `${(rect.top + window.scrollY) - 40}px`;
            document.body.appendChild(label);
            element.addEventListener('mouseleave', () => {
                label.remove();
            });
        })
    });
});
