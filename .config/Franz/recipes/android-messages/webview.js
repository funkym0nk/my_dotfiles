"use strict";

function getStyle(el, styleProp) {
  var value,
      defaultView = (el.ownerDocument || document).defaultView;

  if (defaultView && defaultView.getComputedStyle) {
    styleProp = styleProp.replace(/([A-Z])/g, "-$1").toLowerCase();
    return defaultView.getComputedStyle(el, null).getPropertyValue(styleProp);
  }
}

module.exports = Franz => {
  function getMessages() {
    const messages = document.querySelectorAll('[aria-label=Conversations]>content span:not([class])');
    let unreadCount = 0;

    for (let i = 0; i < messages.length; i++) {
      if (parseFloat(getStyle(messages[i], "fontWeight")) > 500) {
        unreadCount++;
      }
    }

    Franz.setBadge(unreadCount);
  }

  Franz.loop(getMessages);
};