/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var app = angular.module("rhApp");
app.controller("CadastrarFuncionario", function ($scope, crudService, $uibModal, broadCastService,exportService) {
    $scope.funcionario = {};
    $scope.funcionario.formacoes = [];
    $scope.funcionario.idiomas = [];
    $scope.funcionario.certificacoes = [];
    $scope.newFormacoes;
    $scope.newCertificacoes;
    $scope.novoIdioma;
    $scope.indexColor;
    $scope.applyClass = function (option, index) {
        $scope.indexColor = index;
        $scope.funcionario.checked = false;
    };

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
    $scope.niveis = ["Nativo", "Básico", "Intermediário", "Técnico", "Avançado", "Fluente"];
    $scope.pageSize = 4;
//    $scope.certificacoes = searchCertifications();

    $scope.animationsEnabled = true;
    $scope.certifications;

    function validation(employee) {
        console.log(employee);
        var boolean = true;
        if (employee.idFuncionario === null || employee.idFuncionario === undefined || employee.idFuncionario === "") {
            boolean = false;
        }
        if (employee.nome === null || employee.nome === undefined || employee.nome === "") {
            boolean = false;
        }
        if (employee.dtAdmissao === null || employee.dtAdmissao === undefined || employee.dtAdmissao === "") {
            boolean = false;
        }
        if (employee.gestor === null || employee.gestor === undefined || employee.gestor === "") {
            boolean = false;
        }
        if (employee.cargo === null || employee.cargo === undefined || employee.cargo === "") {
            boolean = false;
        }
        if (employee.area === null || employee.area === undefined || employee.area === "") {
            boolean = false;
        }

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
        $scope.funcionario.formacoes = [];
        $scope.funcionario.idiomas = [];
        $scope.funcionario.certificacoes = [];
    };
    $scope.reset = function () {
        $scope.funcionario = {};
    };

    $scope.saveRow = function () {
        $scope.funcionario.checked = !$scope.funcionario.checked;
        console.log($scope.funcionario);
    };
    $scope.addRow = function (novaInformacao, template) {
        if (template === 'formacao') {
            $scope.funcionario.formacoes.push(novaInformacao);
            $scope.newFormacoes = null;
            console.log($scope.funcionario);
        } else if (template === 'certificacao') {
            $scope.funcionario.certificacoes.push(novaInformacao);
            $scope.newCertificacoes = null;
            console.log($scope.funcionario);
        } else if (template === 'idioma') {
            $scope.funcionario.idiomas.push(novaInformacao);
            $scope.novoIdioma = null;
            console.log($scope.funcionario);
        }

    };
    $scope.editRow = function (informacao) {
        $scope.funcionario.checked = !$scope.funcionario.checked;
    };
    $scope.removeRow = function (index, template) {
        if (template === "formacao") {
            $scope.funcionario.formacoes.splice(index, 1);
        } else if (template === "certificacao") {
            $scope.funcionario.certificacoes.splice(index, 1);
        } else if (template === "idioma") {
            $scope.funcionario.idiomas.splice(index, 1);
        }

    };

    $scope.cancelRow = function (information) {
        if (information === "formacao") {
            $scope.newFormacoes = [];
        } else if (information === "certificacao") {
            $scope.newCertificacoes = [];
        } else if (information === "idiomas") {
            $scope.novoIdioma = [];
        }
    };
    
    $scope.readExcel = function (){
        exportService.readExcel();
    };
});
