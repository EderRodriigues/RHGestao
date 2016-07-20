/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.directive("searchAllCertificates", function (crudCertificacoesService) {
    return{
        restrict: 'EA',
        templateUrl: 'searchAllTemplate',
        controller: 'atualizarCertificacaoController',
        scope: '=',
        link: function ($scope, element, attrs) {
            var tamPagina = 5;
            $scope.tamPagina = tamPagina;
            var atPagina = 1;
            $scope.atPagina;
            var pageAssignedSize2 = 5;

            $scope.fltr = "";
            var busFiltro = $scope.fltr;
            var firstTimeSearch3 = false;

            searchForPagination(atPagina, tamPagina, busFiltro);
              $scope.$watch('fltr', function (newFilter) {
                searchForPagination(atPagina, tamPagina, newFilter);
            });

            function searchForPagination(newPage2, atPagina, busFiltro) {
                $("#loader").show();
                if (tamPagina === null) {
                    tamPagina = 1;
                }
                if (busFiltro === undefined) {
                    busFiltro = "";
                }
                crudCertificacoesService.searchFast(newPage2, tamPagina, busFiltro, successOnSearch, errorOnSearch);
            }

            function successOnSearch(data) {
                console.log(data);
                console.log(data.employees);
                $("#loader").hide();
                $scope.certificacoes = data.employees;
                $scope.completo = data.totalEntities;
            }
            function errorOnSearch(error, status) {
                $("#loader").hide();
                console.log("ajax error:" + error);
                console.log("ajax status:" + status);
            }
            
            var firstTimeSearch3 = false;
            $scope.pageChanged = function (novaPagina, tamanhoPagina, buscaFiltro) {
                $scope.atPagina = novaPagina;
                $scope.filtro = buscaFiltro;
//                atualPagina = atualPagina++;
                this.tamPagina = tamanhoPagina;
                var fltr = buscaFiltro;
//                console.log(filtro);
                if (!firstTimeSearch3) {
                    $scope.employees = searchForPagination(novaPagina, this.tamPagina, fltr);
                    console.log("test");
                    console.log($scope.employees);
                } else {
                    firstTimeSearch3 = false;
                }
            };
        }


    };
});