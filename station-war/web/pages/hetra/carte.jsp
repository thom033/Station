    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>

    <%-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> --%>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

    <style type="text/css">
        #map { height:100vh; width: 100%}
    </style>
    <title>OpenStreetMap - Maisons</title>
    <div id="map"></div>   
    <button id="myBtn">Ouvrir le formulaire</button>
    <div id="houseModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h5>Ajouter une Maison</h5>
        <form id="houseForm">
            <div class="form-group">
                <label for="houseName">Nom:</label>
                <input type="text" id="houseName" name="houseName" required>
            </div>
            <div class="form-group">
                <label for="etage">Nb Etage:</label>
                <input type="number" id="etage" name="etage">
            </div>
            <div class="form-group">
                <label for="latitude">Latitude:</label>
                <input type="text" id="latitude" name="latitude">
            </div>
            <div class="form-group">
                <label for="longitude">Longitude:</label>
                <input type="text" id="longitude" name="longitude">
            </div>
            <div class="form-group">
                <label for="length">Longueur:</label>
                <input type="number" id="length" name="length" required>
            </div>
            <div class="form-group">
                <label for="width">Largeur:</label>
                <input type="number" id="width" name="width" required>
            </div>
            <div class="form-group">
                <label for="typeTafo">Type Tafo:</label>
                <select id="typeTafo" name="typeTafo"></select>
            </div>
            <div class="form-group">
                <label for="typeRindrina">Type Rindrina :</label>
                <select id="typeRindrina" name="typeRindrina"></select>
            </div>
            <button type="button" class="btn" onclick="submitForm()">Soumettre</button>
        </form>
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

