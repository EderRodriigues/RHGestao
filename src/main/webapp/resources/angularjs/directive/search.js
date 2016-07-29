/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.directive("search", function (crudService) {
    return {
        restrict: 'EA',
        templateUrl: 'searchTemplate',
        scope: '=',

        link: function ($scope, element, attrs) {
//            var ajax = crudService.search();
//            ajax.success(function(data){
//                $scope.employees = data;
//            }).error(function(error,status){
//               console.log(error); 
//            });
            var tamanhoPagina = 5;
            $scope.tamanhoPagina=tamanhoPagina;
            var atualPagina = 1;
            var pageAssignedSize2 = 5;
          
            $scope.filtro = "";
            var buscaFiltro = $scope.filtro;
            var firstTimeSearch2 = false;
            
            searchForPagination(atualPagina,tamanhoPagina,buscaFiltro);

            $scope.pageChanged = function (novaPagina, tamanhoPagina, buscaFiltro) {
//                $scope.novaPagina = novaPagina;
                $scope.filtro = buscaFiltro;
                atualPagina = atualPagina++;
                this.tamanhoPagina = tamanhoPagina;
                var filtro = buscaFiltro;
                console.log(filtro);
                if (!firstTimeSearch2) {
                    $scope.employees = searchForPagination(novaPagina, this.tamanhoPagina, filtro);
                    console.log("test");
                    console.log($scope.employees);
                } else {
                    firstTimeSearch2 = false;
                }
            };

            $scope.$watch('q2',function (novoFiltro){
                if($scope.q2.length>2){
                 searchForPagination(atualPagina,tamanhoPagina,novoFiltro);   
                }
            });
            function successOnSearch(data) {
                console.log(data);
                $("#loader").hide();
                $scope.employees = data.employees;
                $scope.total2=data.totalEntities;
            }
            function errorOnSearch(error,status) {
                $("#loader").hide();
                console.log("ajax error:" + error);
                console.log("ajax status:" + status);
            }
            function searchForPagination(newPage2, tamanhoPagina, buscaFiltro) {
                $("#loader").show();
                if(tamanhoPagina === null){
                    tamanhoPagina = 1;
                }
                if(buscaFiltro === undefined){
                    buscaFiltro="";
                }                
                crudService.searchFast(newPage2, tamanhoPagina, buscaFiltro,successOnSearch, errorOnSearch);
            }
        }

    };
});