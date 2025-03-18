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

    // Calcul du temps total
    const totalDuration = this.durationValue // convertir en millisecondes

    // Calcul de la proportion de temps restant
    const proportion = ((1-(timeRemaining / totalDuration)) * 60 )


    // Calcul de la nouvelle largeur
    const newWidth = Math.max(0, Math.floor(proportion))

    // Application de la nouvelle largeur
    this.progressBarTarget.style.width = `${newWidth}px`

    // Calcul des secondes restantes (uniquement pour vérification)
    const seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000)
    const minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60))
    const formattedMinutes = minutes.toString().padStart(2, '0')
    const formattedSeconds = seconds.toString()

    // Affichage du résultat
    // this.displayTarget.textContent = `${formattedMinutes}:${formattedSeconds}`
    // this.displayTarget.textContent = `${Math.floor(timeRemaining)}`
    // this.displayTarget.textContent = `${proportion}`
    // this.displayTarget.textContent = `${Math.floor(newWidth)}`
    // this.displayTarget.textContent = `${Math.floor(now/1000)}`
  }
}
