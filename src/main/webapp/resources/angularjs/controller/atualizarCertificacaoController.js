/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var app = angular.module("rhApp");
app.controller("atualizarCertificacaoController", function ($scope, crudService, crudCertificacoesService, $uibModal, broadCastService) {
    $scope.selecionado;
    var index;
    $scope.isCertificateSelected = function (certificacao, indx) {
        console.log("index"+indx);
        index = indx;
        $scope.selecionado = certificacao;
    };

    $scope.save = function (certificacao) {
        console.log(certificacao);

        if (validation(certificacao)) {
            crudCertificacoesService.salvar(certificacao);
            broadCastService.broadCastAlertSuccess("Alterado com sucesso");
            $scope.funcionario = {};

        } else {
            broadCastService.broadCastAlertDanger("Informação inválida");
        }


    };
    $scope.remove = function (certificacao) {
        var boolean = confirm("Deseja excluir?");
        if (boolean) {
            crudCertificacoesService.deletar(certificacao);
            $scope.selecionado = false;
            $scope.certificacoes.splice(index,1);
            broadCastService.broadCastAlertSuccess("Certificação removida com sucesso");
        }
        


    };
    function successOnSearch(data) {
        console.log(data);
        console.log(data.employees);
        $scope.certificacoes = data.employees;
        $scope.completo = data.totalEntities;
    }
    function errorOnSearch(error, status) {
        console.log("ajax error:" + error);
        console.log("ajax status:" + status);
    }
    function validation(certificacao) {
        var boolean = true;
        if (certificacao.id === null || certificacao.id === undefined || certificacao.id==="") {
            boolean = false;
        }
        if (certificacao.nome === null || certificacao.nome === undefined || certificacao.nome==="") {
            boolean = false;
        }
        if (certificacao.empresa === null || certificacao.empresa === undefined || certificacao.empresa === "") {
            boolean = false;
        }
        return boolean;
    }

    function searchForPagination(atPagina, tamPagina, busFiltro) {
        if (tamPagina === null) {
            tamPagina = 1;
        }
        if (busFiltro === undefined) {
            busFiltro = "";
        }
        crudCertificacoesService.searchFast(atPagina, tamPagina, busFiltro, successOnSearch, errorOnSearch);
    }
});

