import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selecting-date"
export default class extends Controller {

  static targets = ["dateElement"]
  static values = {
    date: Date
  }

  connect() {
    console.log("Hello from selecting_date_controller.js")
  }

  day_before(event) {
    // change the date displayed to the previous day available in agenda

    this.dateElementTarget.innerText = "Aujourd'hui";
  }
  day_after(event) {
    // change the date displayed to the next day available in agenda
  }
}
