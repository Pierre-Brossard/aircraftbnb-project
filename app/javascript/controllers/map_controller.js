import { Controller } from '@hotwired/stimulus';
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    range: Number,
    location: Object,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      // style: "mapbox://styles/mapbox/streets-v10"
      style: 'mapbox://styles/sblaaaf/clwrsrt1c018x01qse1e01zul',
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.#addCircleToMap();

    this.map.addControl(
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
      })
    );
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);

      const customMarker = document.createElement('div');
      customMarker.innerHTML = marker.marker_html;

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 16, duration: 2000 });
  }

  #addCircleToMap() {
    const radiusInMeters = this.rangeValue * 1000; // Convertit la portée en mètres
    const center = [this.locationValue.lng, this.locationValue.lat]; // Centre du cercle

    this.map.on('load', () => {
      this.map.addSource('circle', {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: [
            {
              type: 'Feature',
              geometry: {
                type: 'Point',
                coordinates: center,
              },
            },
          ],
        },
      });

      this.map.addLayer({
        id: 'circle-layer',
        type: 'circle',
        source: 'circle',
        paint: {
          'circle-radius': {
            stops: [
              [0, 0],
              [20, (radiusInMeters / 40075) * 512],
            ],
            base: 2,
          },
          'circle-color': '#007cbf',
          'circle-opacity': 0.5,
        },
      });
    });
  }
}
