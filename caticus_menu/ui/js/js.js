// Function to toggle the menu visibility based on Lua messages
function ToggleMenu(show) {
    var menu = document.querySelector('.all');
    if (show) {
        menu.classList.remove('hidden');
        console.log("Menu shown");
    } else {
        menu.classList.add('hidden');
        console.log("Menu hidden");
    }
}

function sendToLua(action) {
    fetch(`https://${GetParentResourceName()}/action`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({ action: action.toLowerCase() })
    }).then(() => {
        console.log(`Action '${action}' sent to Lua client`);
    }).catch(err => {
        console.error("Error sending action to Lua client:", err);
    });
}

// Function to close the menu and notify the FiveM client
function closeMenu() {
    fetch(`https://${GetParentResourceName()}/exit`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(() => {
        console.log("Menu closed");
    }).catch(err => {
        console.error("Error closing menu:", err);
    });
}

document.addEventListener('DOMContentLoaded', function() {
    console.log("DOM fully loaded and parsed");

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            ToggleMenu(item.status);
        }
    });

    // Function to handle button click
    document.querySelectorAll('.all .text').forEach(button => {
        button.addEventListener('click', function() {
            const action = this.textContent.toLowerCase().replace(/\s/g, '');
            console.log(`Button clicked: ${action}`);
            sendToLua(action);
        });
    });

    // ESC key listener
    document.addEventListener('keydown', function (event) {
        if (event.key === "Escape") {
            console.log("Escape key pressed");
            closeMenu();
        }
    });
});
