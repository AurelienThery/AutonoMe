import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static targets = ["mapContainer"]
  static values = {
    apiKey: String,
  }

   connect() {
      mapboxgl.accessToken = this.apiKeyValue
      console.log(this.apiKeyValue)
    }

  async showMap(event) {
    event.preventDefault()

    try {
      const position = await this.getCurrentPosition()
      this.initializeMap(position)
      this.mapContainerTarget.style.display = "block"
    } catch (error) {
      console.error("Erreur :", error)
      alert("Impossible d'obtenir votre position géographique.")
    }
  }

  closeMap() {
    this.mapContainerTarget.style.display = "none"
    if (this.map) {
      this.map.remove()
      this.map = null
    }
  }

  getCurrentPosition() {
    return new Promise((resolve, reject) => {
      navigator.geolocation.getCurrentPosition(
        position => resolve([position.coords.longitude, position.coords.latitude]),
        error => reject(error)
      )
    })
  }

  initializeMap(position) {
    if (this.map) {
      this.map.remove()
    }

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: position,
      zoom: 14
    })

    new mapboxgl.Marker()
      .setLngLat(position)
      .setPopup(new mapboxgl.Popup().setHTML("<p>Tu es ici</p>"))
      .addTo(this.map)
  }
}
