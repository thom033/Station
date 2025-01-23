<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Maison</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Détails des paiements</h2>

        <!-- Formulaire de filtre par année -->
        <form class="form-inline mb-4" method="get" action="${pageContext.request.contextPath}/paiement">
            <label class="mr-2" for="yearFilter">Filtrer par année:</label>
            <select class="form-control mr-2" id="yearFilter" name="year">
                <option value="2021" ${anneeSelectionnee == 2021 ? 'selected' : ''}>2021</option>
                <option value="2022" ${anneeSelectionnee == 2022 ? 'selected' : ''}>2022</option>
                <option value="2023" ${anneeSelectionnee == 2023 ? 'selected' : ''}>2023</option>
                <option value="2024" ${anneeSelectionnee == 2024 ? 'selected' : ''}>2024</option>
            </select>
            <button type="submit" class="btn btn-primary">Filtrer</button>
        </form>
        
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Maison</th>
                    <th scope="col">Mois</th>
                    <th scope="col">Année</th>
                    <th scope="col">Montant Hetra</th>
                    <th scope="col">Date de paiement</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${paiements}" var="paiement">
                    <tr>
                        <td>${paiement.id_maison}</td>
                        <td>${paiement.mois}</td>
                        <td>${paiement.annee}</td>
                        <td><fmt:formatNumber value="${paiement.hetra}" type="currency" currencySymbol="Ar"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty paiement.date_paiement}">
                                    <fmt:formatDate value="${paiement.date_paiement}" pattern="dd/MM/yyyy"/>
                                </c:when>
                                <c:otherwise>
                                    Non payé
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Maison</th>
                    <th scope="col">Nom</th>
                    <th scope="col">Total Paye</th>
                    <th scope="col">Total non Paye</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${sumHetraMaison}" var="sum">
                    <tr>
                        <td>${sum.id_maison}</td>
                        <td>${sum.nom_maison}</td>
                        <td>${sum.total_paye}</td>
                        <td>${sum.total_non_paye}</td>
                        <!-- <td><fmt:formatNumber value="${paiement.hetra}" type="currency" currencySymbol="Ar"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty paiement.date_paiement}">
                                    <fmt:formatDate value="${paiement.date_paiement}" pattern="dd/MM/yyyy"/>
                                </c:when>
                                <c:otherwise>
                                    Non payé
                                </c:otherwise>
                            </c:choose>
                        </td> -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html> 