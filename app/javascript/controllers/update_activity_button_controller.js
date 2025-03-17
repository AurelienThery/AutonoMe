import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["start-button"]

  connect() {
    console.log("I'm connected");
  }

  start(event) {
    // event.preventDefault(); désactivé car il faut recharger la page pour afficher l'activité en cours
    // console.log(event.target.getAttribute("data-activity-id"))
    const activityId = event.target.getAttribute("data-activity-id");

    fetch(`/activities/${activityId}/start`, {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json", //important, sinon le format json n'est pas reconnu
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        // activity_id: activityId,  // ID de l'activité à mettre à jour
        // activity_status: 'inprogress'  // Nouveau statut (par exemple, 'inprogress')
      })
    })

    // proposition de Claude pour la gestion des erreurs
    .then(response => {
      console.log("Response status:", response.status);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      console.log("Success:", data);
      window.location.reload();
    })
    .catch(error => {
      console.error("Erreur complète:", error);
    });
  }

  finish(event) {
    // console.log(event.target.getAttribute("data-activity-id"))
    const activityId = event.target.getAttribute("data-activity-id");

    fetch(`/activities/${activityId}/finish`, {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json", //important, sinon le format json n'est pas reconnu
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({})
    })
    .then(data => {
      console.log("Success:", data);
      window.location.reload();
    })
    .catch(error => {
      console.error("Erreur complète:", error);
    });
  }
}
