<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Maison</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        #map {
            height: 400px;
            margin-bottom: 20px;
        }

        .button-container {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 1000;
        }
    </style>
</head>

<body>
    <!-- Bouton pour voir la liste des arrondissements -->
    <div class="button-container">
        <a href="arrondissement" class="btn btn-primary">Voir la liste des arrondissements</a>
    </div>
    <!-- Fenêtre modale Bootstrap pour les détails de la maison -->
    <div id="map"></div>
      <div class="modal fade" id="houseModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Détails de la Maison</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="houseDetails"></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="houseModal" tabindex="-1" aria-labelledby="houseModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="houseModalLabel">Ajouter une Maison</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="houseForm">
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
                                <select class="form-select" id="typeTafo" name="typeTafo">
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="typeRindrina" class="form-label">Type Rindrina</label>
                                <select class="form-select" id="typeRindrina" name="typeRindrina">
                                </select>
                            </div>
                        </div>
                        <div class="d-grid">
                            <button type="button" class="btn btn-primary" onclick="submitForm()">Soumettre</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialiser la carte
        var map = L.map('map').setView([-18.8792, 47.5079], 13); // Antananarivo

        // Ajouter les tuiles OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);


        // Récupérer les maisons depuis l'attribut de la requête
        var maisons = JSON.parse('${maisons}'); // Utiliser l'attribut `maisons` passé depuis le servlet

        maisons.forEach(function(house) {
            var marker = L.circleMarker([house.latitude, house.longitude], {
                radius: 10, // Augmenter la taille du cercle pour qu'il soit bien visible
                    fillColor: "red", // Couleur de remplissage
                    color: "red", // Couleur du contour
                    weight: 2, // Poids du contour
                    opacity: 1, // Opacité du contour
                    fillOpacity: 0.8 // Opacité du remplissage
                })
                .addTo(map)
                .bindPopup(`<b>${house.nom}</b><br>Longueur: ${house.longueur}m<br>Largeur: ${house.largeur}m`)
                .on('click', function() {
                    // Afficher les détails de la maison dans le modal
                    var details = `Nom: ${house.nom}<br>Longueur: ${house.longueur}m<br>Largeur: ${house.largeur}m<br>Type Tafo: ${house.typeTafo}<br>Type Rindrinda: ${house.typeRindrinda}`;
                    $('#houseDetails').html(details);
                    $('#houseModal').modal('show');
                });

            console.log(house);
        });
        // Ajouter un événement de clic pour afficher les coordonnées dans les champs Latitude et Longitude
        map.on('click', function (e) {
            document.getElementById('latitude').value = e.latlng.lat.toFixed(6);
            document.getElementById('longitude').value = e.latlng.lng.toFixed(6);
            var modal = new bootstrap.Modal(document.getElementById('houseModal'));
            modal.show();
        });

        // Soumettre le formulaire
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

            fetch('http://localhost:8080/station/carte', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(houseData)
            })
                .then(response => {
                    if (response.ok) {
                        alert('Maison ajoutée avec succès!');
                        var modal = bootstrap.Modal.getInstance(document.getElementByI+d('houseModal'));
                        modal.hide();
                    } else {
                        alert('Erreur lors de l\'ajout de la maison.');
                    }
                })
                .catch(error => console.error('Erreur:', error));
        }
        
        async function loadTypeData() {
            try {
                console.log('Chargement des données...');
                const response = await fetch('http://localhost:8080/station/data');
                console.log('Réponse reçue :', response);
                
                if (!response.ok) {
                    throw new Error(`Erreur HTTP : ${response.status}`);
                }

                const data = await response.json();
                console.log('Données reçues :', data);

                const tafoSelect = document.getElementById('typeTafo');
                const rindrinaSelect = document.getElementById('typeRindrina');

                data.typeTafoList.forEach(tafo => {
                    const option = document.createElement('option');
                    // console.log(tafo); --%>
                    option.value = tafo.id_type_tafo;
                    option.textContent = tafo.nom;
                    tafoSelect.appendChild(option);
                });

                data.typeRindrinaList.forEach(rindrina => {
                    const option = document.createElement('option');
                    option.value = rindrina.id_type_rindrina;
                                       // console.log(rindrina);
                    option.textContent = rindrina.nom;
                    rindrinaSelect.appendChild(option);
                });

            } catch (error) {
                console.error('Erreur lors du chargement des données :', error);
            }
        }


        // Charger les données dès que la page est prête
        document.addEventListener('DOMContentLoaded', loadTypeData);
    </script>
</body>

</html>
