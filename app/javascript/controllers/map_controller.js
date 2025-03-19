import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static targets = ["container"]
  static values = {
    destination: String,
    apiKey: String,
    nextActivityName: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.#initializeMap()
  }

  async #initializeMap() {
    try {
      // Créer la carte immédiatement
      this.map = new mapboxgl.Map({
        container: this.containerTarget,
        style: 'mapbox://styles/mapbox/streets-v12',
      })

      // Obtenir les coordonnées
      const [startCoords, endCoords] = await Promise.all([
        this.#getCurrentPosition(),
        this.#geocode(this.destinationValue)
      ])

      // Ajouter les marqueurs
      this.#addMarkers(startCoords, endCoords)

      // Ajouter le trajet
      await this.#addRoute(startCoords, endCoords)

      // Centrer sur le trajet
      this.#centerOnRoute(startCoords, endCoords)

    } catch (error) {
      console.error("Erreur :", error)
      this.containerTarget.innerHTML = "<p>Impossible de charger la carte</p>"
    }
  }

  #addMarkers(startCoords, endCoords) {
    // Marqueur position actuelle
    new mapboxgl.Marker({ color: '#4CAF50' })
      .setLngLat(startCoords)
      .setPopup(new mapboxgl.Popup().setHTML("Je suis ici"))
      .addTo(this.map)

    // Marqueur destination
    new mapboxgl.Marker({ color: '#F44336' })
      .setLngLat(endCoords)
      .setPopup(new mapboxgl.Popup().setHTML(`
        <strong>Prochaine activité :</strong><br>
        ${this.nextActivityNameValue}
      `))
      .addTo(this.map)
  }

  #centerOnRoute(startCoords, endCoords) {
    const bounds = new mapboxgl.LngLatBounds()
      .extend(startCoords)
      .extend(endCoords)

    this.map.fitBounds(bounds, {
      padding: 100,
      maxZoom: 15,
      duration: 0
    })
  }

  async #getCurrentPosition() {
    return new Promise((resolve, reject) => {
      navigator.geolocation.getCurrentPosition(
        position => resolve([position.coords.longitude, position.coords.latitude]),
        error => reject(new Error("Géolocalisation refusée"))
      )
    })
  }

  async #geocode(address) {
    const response = await fetch(
      `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(address)}.json?access_token=${mapboxgl.accessToken}`
    )
    const data = await response.json()
    return data.features[0].center
  }

  async #addRoute(startCoords, endCoords) {
    const response = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/walking/${startCoords[0]},${startCoords[1]};${endCoords[0]},${endCoords[1]}?geometries=geojson&access_token=${mapboxgl.accessToken}`
    )
    const data = await response.json()

    this.map.addLayer({
      id: 'route',
      type: 'line',
      source: {
        type: 'geojson',
        data: {
          type: 'Feature',
          properties: {},
          geometry: data.routes[0].geometry
        }
      },
      layout: {
        'line-join': 'round',
        'line-cap': 'round'
      },
      paint: {
        'line-color': '#2196F3',
        'line-width': 4,
        'line-opacity': 0.7
      }
    })
  }
}
