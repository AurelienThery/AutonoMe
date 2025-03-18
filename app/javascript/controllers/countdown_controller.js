import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {

  static targets = ["display", "progressBar"]
  static values = {
    targetTime: Number,
    duration: Number
  }

  connect() {
    this.interval = setInterval(() => {
      this.updateCountdown()
    }, 1000)
    this.updateCountdown()
  }

  disconnect() {
    if (this.interval) {
      clearInterval(this.interval)
    }
  }
  updateCountdown() {
    const now = Date.now();
    const targetTime = this.targetTimeValue;
    const timeRemainingms = targetTime - now; //in milliseconds
    const timeRemaining = (timeRemainingms/1000) -3600;  // converted in seconds and Timeline corrected

    if (timeRemaining <= 0) {
      // this.displayTarget.textContent = "L'activité est terminée"
      // Prévoir une action --> pop up pour signaler à l'utilisateur de déclarer done!
      this.progressBarTarget.style.width = "60px"
      clearInterval(this.interval)
      return
    }

    // Get the scheduled duration of the activity
    const totalDuration = this.durationValue

    // Calculation of area to cover proportionnaly to time elapsed
    const proportion = ((1-(timeRemaining / totalDuration)) * 60 )


    // Width adapted to integer value
    const newWidth = Math.max(0, Math.floor(proportion))

    // Application de la nouvelle largeur
    this.progressBarTarget.style.width = `${newWidth}px`

    // For testing purpose only (display is not on the features list)
    // const seconds = Math.floor((timeRemaining / 1000))
    // this.displayTarget.textContent = `${seconds}`
  }
}
