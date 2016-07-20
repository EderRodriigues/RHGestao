/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var app = angular.module("rhApp");
app.directive("searchUpdate", function (crudCertificacoesService) {
    return{
        restrict: 'EA',
        templateUrl: 'searchCertificacaoTemplate',
        controller: "cadastrarFuncionario",
        scope: '=',
        link: function ($scope, element, attrs) {

            var pageSize = 2;
            $scope.pageSize = pageSize;
            var currentPage = 1;
            var pageAssignedSize = 5;
            var templateName = attrs.funcionarios;
            $scope.q = "";
            var searchFilter = $scope.q;
            var firstTimeSearch = false;
            searchForPagination(currentPage, pageSize, searchFilter);

            $scope.pageChanged = function (newPage, pageSize, searchFilter) {
                currentPage = currentPage++;
                pageAssignedSize = pageSize;
                var filter = searchFilter;
                console.log(filter);
                if (!firstTimeSearch) {
                    $scope.employees = searchForPagination(newPage, pageAssignedSize, filter);
                } else {
                    firstTimeSearch = false;
                }
            };

            $scope.$watch('q', function (newFilter) {
                searchForPagination(currentPage, pageSize, newFilter);
            });
            function successOnSearch(data) {
                console.log(data);
                console.log(data.employees);
                $scope.employees = data.employees;
                $scope.total = data.totalEntities;
            }
            function errorOnSearch(error, status) {
                console.log("ajax error:" + error);
                console.log("ajax status:" + status);
            }
            function searchForPagination(newPage, pageSize, searchFilter) {
                if (pageSize === null) {
                    pageSize = 1;
                }
                if (searchFilter === undefined) {
                    searchFilter = "";
                }
                crudCertificacoesService.searchFast(newPage, pageSize, searchFilter, successOnSearch, errorOnSearch);
            }
        }
    };
});
