import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "confirmation", "message", "scenarioPopup", "scenarioContent"]

  connect() {
    console.log("HelpCallsController connected")
    this.overlay = document.createElement('div')
    this.overlay.className = 'overlay'
    document.body.appendChild(this.overlay)
  }

  togglePopup() {
    console.log("togglePopup called")
    this.popupTarget.classList.toggle("hidden")
    this.toggleOverlay()
    if (!this.popupTarget.classList.contains("hidden")) {
      this.centerElement(this.popupTarget.querySelector('.popup-content'))
    }
  }

  handleOption(event) {
    console.log("handleOption called")
    const option = event.currentTarget.dataset.option
    let message = ""
    switch (option) {
      case "aller-aux-wc":
        message = "<strong style='font-size: 1.2em;'>Va aux toilettes.</strong>"
        break
      case "trop-de-bruit":
        message = "<strong style='font-size: 1.2em;'>Mets ton casque anti-bruit.</strong>"
        break
      case "j-ai-une-question":
        message = "<strong style='font-size: 1.2em;'>Pose une question à quelqu'un.</strong>"
        break
      default:
        message = "<strong style='font-size: 1.2em;'>Option non reconnue.</strong>"
    }
    this.messageTarget.innerHTML = message
    this.currentOption = option
    this.togglePopup()
    this.showConfirmation()
  }

  showConfirmation() {
    console.log("showConfirmation called")
    this.confirmationTarget.classList.remove("hidden")
    this.centerElement(this.confirmationTarget)
    this.showOverlay()
  }

  confirmResolution() {
    console.log("confirmResolution called")
    alert("👍 Super ! Le problème est résolu.")
    this.closeAll()
  }

  reopenHelp() {
    console.log("reopenHelp called")
    this.confirmationTarget.classList.add("hidden")
    this.togglePopup()
  }

  showScenario() {
    console.log("showScenario called")
    const scenarioContent = this.getScenarioContent(this.currentOption)
    this.scenarioContentTarget.innerHTML = scenarioContent
    this.scenarioPopupTarget.classList.remove("hidden")
    this.confirmationTarget.classList.add("hidden")
    this.centerElement(this.scenarioPopupTarget.querySelector('.scenario-popup-content'))
    this.showOverlay()
  }

  closeScenarioPopup() {
    console.log("closeScenarioPopup called")
    this.scenarioPopupTarget.classList.add("hidden")
    this.confirmationTarget.classList.remove("hidden")
    this.centerElement(this.confirmationTarget)
  }

  closeAll() {
    this.popupTarget.classList.add("hidden")
    this.confirmationTarget.classList.add("hidden")
    this.scenarioPopupTarget.classList.add("hidden")
    this.hideOverlay()
  }

  centerElement(element) {
    const windowHeight = window.innerHeight
    const elementHeight = element.offsetHeight
    element.style.top = `${Math.max((windowHeight - elementHeight) / 2, 0)}px`
  }

  toggleOverlay() {
    if (this.overlay.style.display === 'block') {
      this.hideOverlay()
    } else {
      this.showOverlay()
    }
  }

  showOverlay() {
    this.overlay.style.display = 'block'
    document.body.style.overflow = 'hidden'
  }

  hideOverlay() {
    this.overlay.style.display = 'none'
    document.body.style.overflow = 'auto'
  }
  getScenarioContent(option) {
  switch (option) {
    case "aller-aux-wc":
      return `
        <div class="scenario scenario-wc">
          <button class="close-button" aria-label="Fermer" data-action="click->help-calls#closeScenarioPopup">x</button>
          <h3 class="scenario-title"><span class="scenario-icon">🚽</span> Demander pour aller aux toilettes</h3>
          <ol class="scenario-steps">
            <li class="scenario-step"><span class="picto">🤔</span> <span class="step-text">Je remarque que j'ai besoin d'aller aux toilettes</span></li>
            <li class="scenario-step"><span class="picto">🖐️</span> <span class="step-text">Je lève la main calmement</span></li>
            <li class="scenario-step"><span class="picto">⏳</span> <span class="step-text">J'attends que le professeur me donne la parole</span></li>
            <li class="scenario-step"><span class="picto">🗣️</span> <span class="step-text">Je dis poliment : "Excusez-moi, puis-je aller aux toilettes s'il vous plaît ?"</span></li>
            <li class="scenario-step"><span class="picto">👍</span> <span class="step-text">Si oui, je sors calmement</span></li>
            <li class="scenario-step"><span class="picto">🚫</span> <span class="step-text">Si non, j'attends un moment approprié</span></li>
            <li class="scenario-step"><span class="picto">🔄</span> <span class="step-text">Je reviens discrètement</span></li>
          </ol>
        </div>`

    case "trop-de-bruit":
      return `
        <div class="scenario scenario-noise">
          <button class="close-button" aria-label="Fermer" data-action="click->help-calls#closeScenarioPopup">x</button>
          <h3 class="scenario-title"><span class="scenario-icon">🔊</span> Gérer le bruit excessif</h3>
          <ol class="scenario-steps">
            <li class="scenario-step"><span class="picto">👂</span> <span class="step-text">Je remarque que le bruit me dérange</span></li>
            <li class="scenario-step"><span class="picto">😌</span> <span class="step-text">Je respire profondément</span></li>
            <li class="scenario-step"><span class="picto">🎧</span> <span class="step-text">Je mets mon casque anti-bruit</span></li>
            <li class="scenario-step"><span class="picto">🖐️</span> <span class="step-text">Si nécessaire, je lève la main</span></li>
            <li class="scenario-step"><span class="picto">🗣️</span> <span class="step-text">"Excusez-moi, le bruit me gêne"</span></li>
            <li class="scenario-step"><span class="picto">👂</span> <span class="step-text">J'écoute les instructions</span></li>
          </ol>
        </div>`

    case "j-ai-une-question":
      return `
        <div class="scenario scenario-question">
          <button class="close-button" aria-label="Fermer" data-action="click->help-calls#closeScenarioPopup"></button>
          <h3 class="scenario-title"><span class="scenario-icon">❓</span> Poser une question en classe</h3>
          <ol class="scenario-steps">
            <li class="scenario-step"><span class="picto">💡</span> <span class="step-text">Je repère un moment approprié</span></li>
            <li class="scenario-step"><span class="picto">🖐️</span> <span class="step-text">Je lève la main</span></li>
            <li class="scenario-step"><span class="picto">🗣️</span> <span class="step-text">"J'ai une question s'il vous plaît"</span></li>
            <li class="scenario-step"><span class="picto">❓</span> <span class="step-text">Je pose ma question clairement</span></li>
            <li class="scenario-step"><span class="picto">🤔</span> <span class="step-text">Si besoin : "Pourriez-vous répéter ?"</span></li>
            <li class="scenario-step"><span class="picto">🙏</span> <span class="step-text">Je remercie</span></li>
          </ol>
        </div>`

    default:
      return `<p>Scénario non disponible pour cette situation.</p>`
    }
  }
}
