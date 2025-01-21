<!DOCTYPE html>
<html>
<head>
    <title>Carte d'Antananarivo</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Inclure la bibliothèque Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <!-- Inclure la bibliothèque Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

    <style>
        #map {
            height: 600px;
            width: 100%;
        }
    </style>
</head>
<body>
    <h1>Carte d'Antananarivo</h1>
    <div id="map"></div>

    <script>
        // Initialiser la carte et la centrer sur Antananarivo
        var map = L.map('map').setView([-18.8792, 47.5079], 13);

        // Ajouter une couche de tuiles OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Ajouter un marqueur pour Antananarivo
        L.marker([-18.8792, 47.5079]).addTo(map)
            .bindPopup('Antananarivo, Renivohitra')
            .openPopup();
    </script>
</body>
</html>