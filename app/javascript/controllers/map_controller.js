import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static targets = ["container", "button"]
  static values = {
    destination: String,
    apiKey: String,
    nextActivityName: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = null
    this.isMapVisible = false
  }

  async toggleRoute() {
    if (this.isMapVisible) {
      this.hideMap()
    } else {
      await this.showRoute()
    }
  }

  async showRoute() {
    try {
      const currentPosition = await this.getCurrentPosition()
      const destinationCoords = await this.geocode(this.destinationValue)

      if (!this.map) {
        this.initializeMap(currentPosition, destinationCoords)
      }

      this.containerTarget.style.display = "block"
      this.buttonTarget.textContent = "Fermer la carte"
      this.isMapVisible = true

    } catch (error) {
      console.error("Erreur :", error)
      alert("Impossible d'afficher le trajet. Vérifiez les autorisations de localisation.")
    }
  }

  hideMap() {
    this.containerTarget.style.display = "none"
    this.buttonTarget.textContent = "Voir le trajet depuis ma position"
    this.isMapVisible = false
  }

  getCurrentPosition() {
    return new Promise((resolve, reject) => {
      navigator.geolocation.getCurrentPosition(
        position => resolve([position.coords.longitude, position.coords.latitude]),
        error => reject(error)
      )
    })
  }

  initializeMap(startCoords, endCoords) {
    this.map = new mapboxgl.Map({
      container: this.containerTarget,
      style: 'mapbox://styles/mapbox/streets-v12',
      center: startCoords,
      zoom: 12
    })

    new mapboxgl.Marker({ color: '#00FF00' })
      .setLngLat(startCoords)
      .setPopup(new mapboxgl.Popup().setHTML("Je suis ici"))
      .addTo(this.map)

    new mapboxgl.Marker({ color: '#FF0000' })
      .setLngLat(endCoords)
      .setPopup(new mapboxgl.Popup().setHTML(`${this.nextActivityNameValue}`))
      .addTo(this.map)

    this.addRoute(startCoords, endCoords)

    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend(startCoords)
    bounds.extend(endCoords)
    this.map.fitBounds(bounds, { padding: 50 })
  }

  async geocode(address) {
    const response = await fetch(
      `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(address)}.json?access_token=${mapboxgl.accessToken}`
    )
    const data = await response.json()
    return data.features[0].center
  }

  async addRoute(startCoords, endCoords) {
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
        'line-color': '#3887be',
        'line-width': 4
      }
    })
  }
}
