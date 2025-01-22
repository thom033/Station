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
    <script src="/assets/js/hetra/loadDataFormulaire.js"></script>
</head>
<body>
    <div id="map"></div>   
    <!-- Fenêtre modale Bootstrap -->
    <div class="modal fade" id="houseModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Ajouter une Maison</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="houseForm">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="houseName">Nom:</label>
                                <input type="text" class="form-control" id="houseName" name="houseName" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="longitude">Nb Etage:</label>
                                <input type="number" class="form-control" id="etage" name="etage">
                            </div>
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
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="typeTafo">Type Tafo:</label>
                                <select id="typeTafo" name="typeTafo" class="form-control"></select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="typeRindrina">Type Rindrina :</label>
                                <select id="typeRindrina" name="typeRindrina" class="form-control"></select>
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

        // Ajouter un événement de clic pour créer une maison
        map.on('click', function(e) {
            $('#latitude').val(e.latlng.lat);
            $('#longitude').val(e.latlng.lng);
            $('#houseModal').modal('show');
        });

        // Fonction pour soumettre le formulaire
        function submitForm() {
            var houseData = {
                nom: $('#houseName').val(),
                longueur: $('#length').val(),
                largeur: $('#width').val(),
                typeTafo: $('#typeTafo').val(),
                typeRindrina: $('#typeRindrina').val(),
                latitude: $('#latitude').val(),
                longitude: $('#longitude').val(),
                nbrEtage: $('#etage').val()            
            };

            console.log("Données maison:", houseData);

            // Simuler une requête (à adapter pour votre backend)
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
                    $('#houseModal').modal('hide');
                } else {
                    alert('Erreur lors de l\'ajout de la maison.');
                }
            })
            .catch(error => console.error('Erreur:', error));
        }

        // Exemple de recherche
        $('#searchBtn').click(function() {
            var searchTerm = $('#searchInput').val();
            console.log("Recherche pour:", searchTerm);

            // Simuler une requête (à adapter)
            fetch(`http://localhost:8080/searchMaison?name=${searchTerm}`)
                .then(response => response.json())
                .then(data => {
                    $('#houseList').empty();
                    data.forEach(function(house) {
                        $('#houseList').append(`<div>${house.name} - (${house.latitude}, ${house.longitude})</div>`);
                    });
                })
                .catch(error => console.error('Erreur:', error));
        });
    </script>
    <%-- script get data --%>
    <script>
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
                    console.log(tafo);
                    option.value = tafo.id_type_tafo;
                    option.textContent = tafo.nom;
                    tafoSelect.appendChild(option);
                });

                data.typeRindrinaList.forEach(rindrina => {
                    const option = document.createElement('option');
                    option.value = rindrina.id_type_rindrina;
                                        console.log(rindrina);
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
