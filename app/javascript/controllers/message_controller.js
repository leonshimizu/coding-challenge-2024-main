import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["orderId", "recipientId", "message"];

  submit(event) {
    event.preventDefault();

    const orderId = this.orderIdTarget.value;
    const recipientId = this.recipientIdTarget.value;
    const message = this.messageTarget.value;

    if (!recipientId || !message.trim()) {
      alert("Please select a recipient and enter a message.");
      return;
    }

    // Send data via Stimulus Reflex or AJAX
    this.sendMessage(orderId, recipientId, message);
  }

  sendMessage(orderId, recipientId, message) {
    fetch("/messages", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({
        message: {
          order_id: orderId,
          recipient_id: recipientId,
          message: message,
        },
      }),
    })
      .then((response) => {
        if (response.ok) {
          location.reload(); // Reload page on success
        } else {
          alert("Failed to send message.");
        }
      })
      .catch((error) => console.error("Error:", error));
  }
}
