import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["start-button"]

  connect() {
    console.log("I'm connected");
  }

  start(event) {
    event.preventDefault();
    console.log(event.target.getAttribute("data-activity-id"))
    const activityId = event.target.getAttribute("data-activity-id");

    // fetch("/activites", {
    //   method: 'PATCH',
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    //   body: JSON.stringify({
    //     activity_id: activityId,  // ID de l'activité à mettre à jour
    //     activity_status: 'inprogress'  // Nouveau statut (par exemple, 'inprogress')
    //   })
    // })

    // .then(response => response.json())
    // .then(data => {
    //   // ajouter un rafraichissement de la page pour que la carte inprogress
    //   // s'affiche et soit collée à la navbar
    //   console.log(data);
    // })
    // .catch(error => {
    //   console.error("Erreur:", error);
    // });
  }
}
