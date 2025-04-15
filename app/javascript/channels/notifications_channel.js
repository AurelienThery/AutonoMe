import consumer from "./consumer";

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    const notificationContainer = document.getElementById("notifications");
    const notification = document.createElement("div");
    notification.className = "notification";
    notification.textContent = data.message;
    notificationContainer.appendChild(notification);

    // Supprimer la notification après 5 secondes
    setTimeout(() => {
      notification.remove();
    }, 5000);
  }
});
