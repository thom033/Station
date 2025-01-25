        <!-- Include jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
        <!-- Include DataTables JS -->
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        
        <!-- Include Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
        <!-- Include DataTables Bootstrap JS -->
        <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
        
        <div class="content-wrapper" >
    
        <!-- Carte -->
        <div id="map"></div>
    
        <!-- Fenêtre modale Bootstrap pour ajouter une maison -->
        <div class="modal fade" id="houseDetailsModal" tabindex="-1" aria-labelledby="houseDetailsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="houseDetailsModalLabel">Ajouter une Maison</h5>
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
            </div>
        </div>
        </div>
    
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
                const modal = new bootstrap.Modal(document.getElementById('houseDetailsModal'));
                modal.show();
            });
    
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
                            bootstrap.Modal.getInstance(document.getElementById('houseDetailsModal')).hide();
                            document.getElementById('houseForm').reset();
                            refreshMaisons();
                        } else {
                            alert('Erreur lors de l\'ajout de la maison.');
                        }
                    })
                    .catch(error => console.error('Erreur :', error));
            }
        </script>
    
    