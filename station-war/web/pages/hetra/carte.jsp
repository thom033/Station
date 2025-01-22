<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style type="text/css">
        html, body { height: 100%; margin: 0; padding: 0 }
        #map { height: 100%; width: 75%; float: left; }
    </style>
    <title>OpenStreetMap - Maisons</title>
</head>
<body>
    <div id="map"></div>   
    <!-- Fenêtre modale Bootstrap pour les détails de la maison -->
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

    <!-- Fenêtre modale Bootstrap pour l'ajout de la maison -->
    <div class="modal fade" id="addHouseModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Ajouter une Maison</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="houseForm">
                        <div class="form-group">
                            <label for="houseName">Nom:</label>
                            <input type="text" class="form-control" id="houseName" name="houseName" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="latitude">Latitude:</label>
                                <input type="text" class="form-control" id="latitude" name="latitude">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="longitude">Longitude:</label>
                                <input type="text" class="form-control" id="longitude" name="longitude">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="length">Longueur:</label>
                                <input type="number" class="form-control" id="length" name="length" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="width">Largeur:</label>
                                <input type="number" class="form-control" id="width" name="width" required>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="submitForm()">Soumettre</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
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
            // Ajouter une épingle pour chaque maison
            var marker = L.marker([house.latitude, house.longitude], {icon: L.icon({iconUrl: 'https://iconarchive.com/download/i10837/google/noto-emoji-animals-nature/22215-poodle.ico', iconSize: [25, 25]})})
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

        // Ajouter un événement de clic pour créer une maison
        map.on('click', function(e) {
            $('#latitude').val(e.latlng.lat);
            $('#longitude').val(e.latlng.lng);
            $('#addHouseModal').modal('show');
        });

        // Fonction pour soumettre le formulaire
        function submitForm() {
            var houseData = {
                name: $('#houseName').val(),
                length: $('#length').val(),
                width: $('#width').val(),
                latitude: $('#latitude').val(),
                longitude: $('#longitude').val()
            };

            console.log("Données maison:", houseData);

            // Simuler une requête (à adapter pour votre backend)
            fetch('http://localhost:8087/station/carte', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(houseData)
            })
            .then(response => {
                if (response.ok) {
                    alert('Maison ajoutée avec succès!');
                    $('#addHouseModal').modal('hide');
                    window.location.reload(); // Recharger la page pour voir la nouvelle maison
                } else {
                    alert('Erreur lors de l\'ajout de la maison.');
                }
            })
            .catch(error => console.error('Erreur:', error));
        }
    </script>
</body>
</html>
