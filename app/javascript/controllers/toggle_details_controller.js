import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-details"
export default class extends Controller {

  static targets = ["togglableElement", "caretIcon"]
  static values = { activityId: Number }
  connect() {
    console.log("Toggle details connected");
    this.always_open()
  }

  display(event) {
    event.preventDefault();
    console.log(this.togglableElementTarget)
    this.togglableElementTarget.classList.toggle("d-none");
    this.caretIconTarget.classList.toggle("fa-caret-rotated");
    console.log("Activity-ID:", event.params.activityId);
  }

  always_open() {
    this.togglableElementTarget.classList.remove("d-none");
  }
}
