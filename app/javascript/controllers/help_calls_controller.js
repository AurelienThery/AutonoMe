import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "confirmation", "message", "scenarioPopup", "scenarioContent"]

  connect() {
    console.log("HelpCallsController connected")
  }

  togglePopup() {
    console.log("togglePopup called")
    this.popupTarget.classList.toggle("hidden")
  }

  handleOption(event) {
    console.log("handleOption called")
    const option = event.currentTarget.dataset.option
    let message = ""
    switch (option) {
      case "aller-aux-wc":
        message = "Demande à ton professeur."
        break
      case "trop-de-bruit":
        message = "Mets ton casque anti-bruit."
        break
      case "j-ai-une-question":
        message = "Pose la question à ton professeur."
        break
      default:
        message = "Option non reconnue."
    }
    console.log(message)
    console.log(this.messageTarget)
    this.messageTarget.textContent = message
    this.currentOption = option
    this.togglePopup()
    this.showConfirmation()
  }

  showConfirmation() {
    console.log("showConfirmation called")
    this.confirmationTarget.classList.remove("hidden")
  }

  confirmResolution() {
    console.log("confirmResolution called")
    alert("👍 Super ! Le problème est résolu.")
    this.confirmationTarget.classList.add("hidden")
    this.closeScenarioPopup() // Ferme le popup du scénario social
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
  }

  closeScenarioPopup() {
    console.log("closeScenarioPopup called")
    this.scenarioPopupTarget.classList.add("hidden")
  }

  getScenarioContent(option) {
    switch (option) {
      case "aller-aux-wc":
        return `
          <h3>🚽 Scénario social : Demander pour aller aux toilettes</h3>
          <ol>
            <li><span class="picto">🤔</span> Je remarque que j'ai besoin d'aller aux toilettes.</li>
            <li><span class="picto">🖐️</span> Je lève la main calmement.</li>
            <li><span class="picto">⏳</span> J'attends que le professeur me donne la parole.</li>
            <li><span class="picto">🗣️</span> Je dis poliment : "Excusez-moi, puis-je aller aux toilettes s'il vous plaît ?"</li>
            <li><span class="picto">👍</span> Si le professeur dit oui, je me lève doucement et je sors de la classe.</li>
            <li><span class="picto">🚫</span> Si le professeur dit non, je reste calme et j'attends le moment approprié.</li>
            <li><span class="picto">🔄</span> Quand je reviens, je rentre discrètement et je reprends mon travail.</li>
          </ol>
        `
      case "trop-de-bruit":
        return `
          <h3>🔊 Scénario social : Gérer le bruit excessif</h3>
          <ol>
            <li><span class="picto">👂</span> Je remarque que le bruit me dérange.</li>
            <li><span class="picto">😌</span> Je prends une grande respiration pour rester calme.</li>
            <li><span class="picto">🎧</span> Je sors mon casque anti-bruit de mon sac.</li>
            <li><span class="picto">🤫</span> Je mets doucement mon casque sur mes oreilles.</li>
            <li><span class="picto">🖐️</span> Si le bruit est toujours trop fort, je lève la main.</li>
            <li><span class="picto">🗣️</span> Quand le professeur me donne la parole, je dis : "Excusez-moi, le bruit me gêne beaucoup."</li>
            <li><span class="picto">👂</span> J'écoute la réponse du professeur et je suis ses instructions.</li>
          </ol>
        `
      case "j-ai-une-question":
        return `
          <h3>❓ Scénario social : Poser une question en classe</h3>
          <ol>
            <li><span class="picto">💡</span> Je réalise que j'ai une question sur le cours.</li>
            <li><span class="picto">⏳</span> J'attends un moment où le professeur ne parle pas.</li>
            <li><span class="picto">🖐️</span> Je lève la main et j'attends patiemment.</li>
            <li><span class="picto">🗣️</span> Quand le professeur me donne la parole, je dis : "Excusez-moi, j'ai une question."</li>
            <li><span class="picto">❓</span> Je pose ma question clairement et brièvement.</li>
            <li><span class="picto">👂</span> J'écoute attentivement la réponse du professeur.</li>
            <li><span class="picto">🤔</span> Si je ne comprends pas, je peux dire : "Pourriez-vous expliquer autrement, s'il vous plaît ?"</li>
            <li><span class="picto">🙏</span> Je remercie le professeur pour son explication.</li>
          </ol>
        `
      default:
        return "<p>Aucun scénario disponible pour cette situation.</p>"
    }
  }
}
