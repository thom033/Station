<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carte</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include Leaflet CSS -->
    <link href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" rel="stylesheet">
    <!-- Include DataTables CSS -->
    <link href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <!-- Include Select2 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet">
    <style>
        #map {
            height: 500px; /* Définir une hauteur pour l'élément de la carte */
        }
        #houseFormSection {
            display: none; /* Masquer le formulaire par défaut */
        }
    </style>
</head>
<body>
    <div class="content-wrapper">
        <!-- Carte -->
        <div id="map"></div>

        <!-- Bouton pour afficher/masquer le formulaire -->
        <button class="btn btn-primary mt-3" onclick="toggleForm()">Ajouter une Maison</button>

        <!-- Section pour le formulaire d'insertion de maison -->
        <div id="houseFormSection" class="mt-3">
            <form id="houseForm" action="cartes" method="POST">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="houseName" class="form-label">Nom</label>
                        <input type="text" class="form-control" id="houseName" name="houseName" required>
                    </div>
                    <div class="col-md-6">
                        <label for="etage" class="form-label">Nb Etage</label>
                        <input type="number" class="form-control" id="etage" name="etage">
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="length" class="form-label">Longueur</label>
                        <input type="number" class="form-control" id="length" name="length" required>
                    </div>
                    <div class="col-md-6">
                        <label for="width" class="form-label">Largeur</label>
                        <input type="number" class="form-control" id="width" name="width" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="latitude" class="form-label">Latitude</label>
                        <input type="text" class="form-control" id="latitude" name="latitude" readonly>
                    </div>
                    <div class="col-md-6">
                        <label for="longitude" class="form-label">Longitude</label>
                        <input type="text" class="form-control" id="longitude" name="longitude" readonly>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="typeTafo" class="form-label">Type Tafo</label>
                        <select class="form-select" id="typeTafo" name="typeTafo"></select>
                    </div>
                    <div class="col-md-6">
                        <label for="typeRindrina" class="form-label">Type Rindrina</label>
                        <select class="form-select" id="typeRindrina" name="typeRindrina"></select>
                    </div>
                </div>
                <div class="d-grid">
                    <button type="button" class="btn btn-primary" onclick="submitForm()">Soumettre</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Include Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <!-- Include DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
    <!-- Include Select2 JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <!-- Include Socket.IO -->
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    <script>
        // Initialiser la carte
        const map = L.map('map').setView([-18.8792, 47.5079], 13);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        const markersLayer = L.layerGroup().addTo(map);

        function addMaisonMarker(maison) {
            L.marker([maison.latitude, maison.longitude])
                .addTo(markersLayer)
                .bindPopup("<b>Nom:</b> " + maison.nom + "<br> <b>Etages:</b> " + maison.etage + "<br> <b>Largeur:</b> " + maison.largeur + " m<br> <b>Longueur:</b> " + maison.longueur + " m");        
        }

        async function refreshMaisons() {
            try {
                const response = await fetch('http://localhost:8087/station/maisons');
                const data = await response.json();
                markersLayer.clearLayers();
                data.forEach(addMaisonMarker);
            } catch (error) {
                console.error('Erreur lors du chargement des maisons :', error);
            }
        }

        async function loadTypeData() {
            try {
                const response = await fetch('http://localhost:8087/station/data');
                const data = await response.json();

                const tafoSelect = document.getElementById('typeTafo');
                const rindrinaSelect = document.getElementById('typeRindrina');

                data.typeTafoList.forEach(tafo => {
                    const option = document.createElement('option');
                    option.value = tafo.id_type_tafo;
                    option.textContent = tafo.nom;
                    tafoSelect.appendChild(option);
                });

                data.typeRindrinaList.forEach(rindrina => {
                    const option = document.createElement('option');
                    option.value = rindrina.id_type_rindrina;
                    option.textContent = rindrina.nom;
                    rindrinaSelect.appendChild(option);
                });
            } catch (error) {
                console.error('Erreur lors du chargement des types :', error);
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            refreshMaisons();
            loadTypeData();
        });

        map.on('click', e => {
            document.getElementById('latitude').value = e.latlng.lat.toFixed(6);
            document.getElementById('longitude').value = e.latlng.lng.toFixed(6);
            toggleForm(true);
        });

        function toggleForm(show) {
            const formSection = document.getElementById('houseFormSection');
            if (show) {
                formSection.style.display = 'block';
            } else {
                formSection.style.display = formSection.style.display === 'none' ? 'block' : 'none';
            }
        }

        function submitForm() {
            const houseData = {
                nom: document.getElementById('houseName').value,
                longueur: document.getElementById('length').value,
                largeur: document.getElementById('width').value,
                typeTafo: document.getElementById('typeTafo').value,
                typeRindrina: document.getElementById('typeRindrina').value,
                latitude: document.getElementById('latitude').value,
                longitude: document.getElementById('longitude').value,
                nbrEtage: document.getElementById('etage').value,
            };

            fetch('http://localhost:8087/station/cartes', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(houseData)
            })
                .then(response => {
                    if (response.ok) {
                        alert('Maison ajoutée avec succès!');
                        document.getElementById('houseForm').reset();
                        refreshMaisons();
                        toggleForm(false);
                    } else {
                        alert('Erreur lors de l\'ajout de la maison.');
                    }
                })
                .catch(error => console.error('Erreur :', error));
        }
    </script>
</body>
</html>