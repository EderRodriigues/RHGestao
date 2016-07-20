/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var app = angular.module("rhApp");
app.controller("CadastrarFuncionario", function ($scope, crudService, crudCertificacoesService, $uibModal, broadCastService) {
    $scope.funcionario = {};
    $scope.funcionario.formacoes = {};
    $scope.languages = ["Português", "Inglês", "Espanhol", "Frânces", "Alemão", "Italiano", "Grego", "Russo", "Indi", "Japônes", "Chinês", "Mandarim", "Hebraíco"];
    $scope.options = ["Dados Cadastrais", "Formação Acadêmica", "Idioma", "Certificação"];
    $scope.optionsBoolean = [false, false, false, false];
    $scope.booleanForm = false;
    $scope.ativarForm = function (option) {
        for (var i = 0; i < $scope.optionsBoolean.length; i++) {
            $scope.optionsBoolean[i] = false;
        }
        $scope.booleanForm = true;
        $scope.optionsBoolean[option] = true;
    };
    $scope.niveis = ["Básico", "Intermediário", "Técnico", "Avançado", "Fluente"];
    $scope.pageSize = 4;
//    $scope.certificacoes = searchCertifications();

    $scope.animationsEnabled = true;
    $scope.certifications;

    $scope.selectCopiaFormacao = function (copia) {
        $scope.funcionario.formacoes.copiaCertificado = copia;
        console.log($scope.funcionario.formacao.copiaCertificado);
    };
    $scope.selectCopiaCertificacao = function (copia) {
        $scope.funcionario.certificacao.copia = copia;
        console.log($scope.funcionario.certificacao.copia);
    };

    function validation(employee) {
        var boolean = true;
//        if (employee.idFuncionario === null || employee.idFuncionario === undefined || employee.idFuncionario === "") {
//            boolean = false;
//        }
//        if (employee.nome === null || employee.nome === undefined || employee.nome ==="") {
//            boolean = false;
//        }

//        if (employee.certificacoes === null || employee.certificacoes === undefined) {
//            boolean = false;
//        }
//        if (employee.dtNascimento === null || employee.dtNascimento === undefined || employee.dtNascimento==="") {
//            boolean = false;
//        }
//        if (employee.setor === null || employee.setor === undefined || employee.setor==="") {
//            boolean = false;
//        }
        return boolean;
    }
    $scope.save = function () {
        console.log($scope.funcionario);
        if ($scope.funcionario.idFuncionario === null || $scope.funcionario.idFuncionario === undefined) {
            $scope.funcionario.idFuncionario = 0;
            console.log($scope.funcionario);
        }
        if (validation($scope.funcionario)) {
            crudService.save($scope.funcionario);
            broadCastService.broadCastAlertSuccess("Salvo com Sucesso");
        } else {
            broadCastService.broadCastAlertDanger("Informação inválida");
        }

        $scope.funcionario = {};
//        for (var i = 0; i < $scope.optionsBoolean.length; i++) {
//            $scope.optionsBoolean[i] = false;
//        }

    };
    $scope.reset = function () {
        $scope.funcionario = {};
    };


//    $scope.openModal = function (size, certificacoes) {
//
//        var modalInstance = $uibModal.open({
//            animation: $scope.animationsEnabled,
//            templateUrl: 'modalCertificacaoTemplate',
//            controller: 'modalCertificacaoController',
//            size: size,
//            resolve: {
//                certificacoes: function () {
//                    return $scope.certificacoes;
//                },
//                certificatesSelecionadas: function () {
//                    return certificacoes;
//                }
//            }
//        });
//
//        modalInstance.result.then(function (selectedItem) {
//            var selected = selectedItem;
//            $scope.funcionario.certificacoes = selected;
//            console.log("Resultado");
//            console.log($scope.funcionario.certificacoes);
//        });
//    };


//    function searchCertifications() {
//        var ajaxget = crudCertificacoesService.searchCertificacoes();
//        ajaxget.success(function (data) {
////            console.log(data);
//            $scope.certificacoes = data;
//            console.log($scope.certificacoes);
//        }).error(function (error, status) {
//            console.log("ajax error:" + error);
//            console.log("ajax status:" + status);
//        }).finally(function () {
//        }).catch(function (error) {
//        });
//    }


});
