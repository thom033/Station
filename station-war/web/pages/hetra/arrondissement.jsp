
    <div class="content-wrapper" >
        <h2 class="mb-4">Liste des Arrondissements</h2>
        
        <!-- Formulaire de filtre par année -->
        <form class="form-inline mb-4">
            <label class="mr-2" for="yearFilter">Filtrer par annee:</label>
            <select class="form-control mr-2" id="yearFilter" name="year">
                <option value="2021">2021</option>
                <option value="2022">2022</option>
                <option value="2023">2023</option>
                <!-- Ajoutez d'autres années si nécessaire -->
            </select>
            <button type="submit" class="btn btn-primary">Filtrer</button>
        </form>
        
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Arrondissement</th>
                    <th scope="col">Total Payer</th>
                    <th scope="col">Total Non Paye</th>
                </tr>
            </thead>
            <tbody>

                <%-- <c:forEach var="arrondissement" items="${arrondissements}">
                    <tr>
                        <td>${arrondissement.nom}</td>
                        <td>${arrondissement.total_paye}</td>
                        <td>${arrondissement.total_rest</td>
                    </tr>
                </c:forEach> --%>
            </tbody>
        </table>
    </div>

