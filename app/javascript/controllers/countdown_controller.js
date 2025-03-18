import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {

  static targets = ["display", "progressBar"]
  static values = {
    targetTime: Number,
    duration: Number
  }

  connect() {
    this.initialWidth = 0 // largeur initiale en pixels du timer orange
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
    const now = new Date().getTime()
    const targetTime = this.targetTimeValue
    const timeRemaining = targetTime - now

    if (timeRemaining <= 0) {
      // this.displayTarget.textContent = "L'activité est terminée"
      // Prévoir une action --> pop up pour signaler à l'utilisateur de déclarer done!
      this.progressBarTarget.style.width = "60px"
      clearInterval(this.interval)
      return
    }

    // Calcul du temps total
    const totalDuration = this.durationValue * 1000 // convertir en millisecondes

    // Calcul de la proportion de temps restant
    const proportion = timeRemaining / totalDuration

    // Calcul de la nouvelle largeur
    const newWidth = Math.max(0, Math.floor(this.initialWidth * proportion))

    // Application de la nouvelle largeur
    this.progressBarTarget.style.width = `${newWidth}px`

    // Calcul des secondes restantes (uniquement pour vérification)
    const seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000)
    const formattedSeconds = seconds.toString()

    // Affichage du résultat
    this.displayTarget.textContent = `${formattedSeconds}`
  }
}
