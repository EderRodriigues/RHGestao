/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.controller("modalCertificacaoController", function ($scope, $uibModalInstance, certificacoes, certificatesSelecionadas, crudCertificacoesService) {
    var pageSize = 5;
    $scope.pageSize = pageSize;
    var currentPage = 1;
    var pageAssignedSize = 5;

    $scope.q = "";
    var searchFilter = $scope.q;
    var firstTimeSearch = false;
    var selectsTemp = [];
    searchForPagination(currentPage, pageSize, searchFilter);

    $scope.pageChanged = function (newPage, pageSize, searchFilter) {
        currentPage = currentPage++;
        pageAssignedSize = pageSize;
        var filter = searchFilter;
        console.log(filter);
        if (!firstTimeSearch) {
            searchForPagination(newPage, pageAssignedSize, filter);
        } else {
            firstTimeSearch = false;
        }
    };

    $scope.$watch('q', function (newFilter) {
        searchForPagination(currentPage, pageSize, newFilter);
    });
    function successOnSearch(data) {
        $scope.certBd = data.employees;

        if (certificatesSelecionadas === undefined) {
            console.log("certificatesSelecionadas");
        } else {
            angular.forEach($scope.certBd, function (value, index) {
                for (var i = 0; i < certificatesSelecionadas.length; i++) {
                    if ($scope.certBd[index].nome === certificatesSelecionadas[i].nome) {
                        $scope.certBd[index].checked = true;
                        console.log($scope.certBd[index].checked);
                    }
                }
            });
        }
        console.log("selectsTemp");
        for (var i = 0; i < $scope.certBd.length; i++) {
            for (var j = 0; j < selectsTemp.length; j++) {
                if ($scope.certBd[i].nome === selectsTemp[j].nome) {
                    $scope.certBd[i].checked = true;
                }
            }
        }
        $scope.certificacaoBd = $scope.certBd;
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







    var selects = [];
    if (certificatesSelecionadas !== undefined) {
        for (var i = 0; i < certificatesSelecionadas.length; i++) {
            selects.push(certificatesSelecionadas[i]);
        }
    }

    $scope.selecionarCertificacao = function (certificacao) {
        var cont = 0;
        var boolean = true;
        if (angular.isUndefined(selectsTemp[0])) {
            selectsTemp.push(certificacao);
            console.log("Undefined");
            console.log(selectsTemp);
        } else {
            for (var i = 0; i < selectsTemp.length; i++) {
                if (selectsTemp.nome === certificacao.nome) {
                    selectsTemp.splice(i, 1);
                    boolean = false;
                }
            }
            if (boolean) {
                selectsTemp.push(certificacao);
            }
        }
        if (selects[0] === undefined) {
            selects.push(certificacao);
        } else {
            for (var i = 0; i < selects.length; i++) {
                if (selects[i].nome === certificacao.nome) {
                    selects.splice(i, 1);
                    cont = -2;
                }
                cont++;
            }
            if (cont === selects.length) {
                selects.push(certificacao);
            }
        }

        console.log(selects);
        console.log(selects[0]);
    };

    $scope.ok = function () {

        console.log(selects);
        $uibModalInstance.close(selects);
    };
    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };
});