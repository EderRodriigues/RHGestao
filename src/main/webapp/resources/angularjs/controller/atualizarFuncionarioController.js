/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.controller("atualizarFuncionario", function ($scope, crudService, $uibModal, broadCastService, exportService) {
    $scope.funcionarios;
    $scope.selecionado;
    $scope.languages = ["Português", "Inglês", "Espanhol", "Frânces", "Alemão", "Italiano", "Grego", "Russo", "Indi", "Japônes", "Chinês", "Mandarim", "Hebraíco"];
    $scope.niveis = ["Avançado", "Básico", "Fluente", "Intermediário", "Nativo", "Técnico"];
    $scope.options = ["Dados Cadastrais", "Formação Acadêmica", "Idioma", "Certificação"];
    $scope.optionsBoolean = [false, false, false, false];
    $scope.newFormacoes;
    $scope.newcertificacoes;
    $scope.novoIdioma;
    $scope.indexColor;
    $scope.applyClass = function (option, index) {
        $scope.indexColor = index;
    };
    $scope.buscar = function (nome) {
        console.log(nome);
        searchByName(nome);
    };
    $scope.ativarForm = function (option) {
        for (var i = 0; i < $scope.optionsBoolean.length; i++) {
            $scope.optionsBoolean[i] = false;
        }
        $scope.booleanForm = true;
        $scope.optionsBoolean[option] = true;
    };
    $scope.selectCopiaFormacao = function (copia) {
//        $scope.funcionario.formacoes.copiaCertificado = copia;
        $scope.newFormacoes.copiaCertificado = copia;
        console.log($scope.newFormacoes.copiaCertificado);
        console.log($scope.newFormacoes);

    };
    $scope.isEmployeeSelected = function (employee,index) {
        $("#loader").show();
        console.log("employee");
        console.log(employee);
        $scope.indexEmployee = index;
        $scope.selecionado = employee;
        $("#loader").hide();
    };
    $scope.save = function (select) {
        console.log(select);
        
        if (validation(select)) {
            crudService.save(select);
            broadCastService.broadCastAlertSuccess("Alterado com sucesso");
            $scope.funcionario = {};
        } else {
            broadCastService.broadCastAlertDanger("Informação inválida");
        }


    };
    $scope.remove = function (employee) {
        var boolean = confirm("Deseja excluir?");
        if (boolean) {
            angular.forEach($scope.employees, function (value, index) {
                if (employee.nome === value.nome) {
                    $scope.employees.splice(index, 1);
                    console.log("ok");
                }
            });
            crudService.remove(employee);
            $scope.selecionado = false;
            broadCastService.broadCastAlertSuccess("Funcionário removido com sucesso");
        }


    };
    $scope.selecionar = function (funcionario) {
        $scope.selecionado = funcionario;
        searchCertifications();
    };
//
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
        crudService.searchFast(newPage, pageSize, searchFilter, successOnSearch, errorOnSearch);
    }
    $scope.saveRow = function () {
        $scope.selecionado.checked = !$scope.selecionado.checked;
//        $scope.funcionario.formacoes[index] = editCertificacao;
//        $scope.newFormacoes = [];
        console.log($scope.selecionado);
    };
    $scope.addRow = function (novaInformacao, template) {
        if (template === 'formacao') {
            $scope.selecionado.formacoes.push(novaInformacao);
            $scope.newFormacoes = null;
            console.log($scope.selecionado);
        } else if (template === 'certificacao') {
            $scope.selecionado.certificacoes.push(novaInformacao);
            $scope.newCertificacoes = null;
            console.log($scope.selecionado);
        } else if (template === 'idioma') {
            $scope.selecionado.idiomas.push(novaInformacao);
            $scope.novoIdioma = null;
            console.log($scope.selecionado);
        }

    };
    $scope.editRow = function (formacao) {
        $scope.selecionado.checked = !$scope.selecionado.checked;
    };
    $scope.removeRow = function (index, template) {
        if (template === "formacao") {
            $scope.selecionado.formacoes.splice(index, 1);
        } else if (template === "certificacao") {
            $scope.selecionado.certificacoes.splice(index, 1);
        } else if (template === "idioma") {
            $scope.selecionado.idiomas.splice(index, 1);
        }

    };
    
    var columns = ["Nome","Cargo","Data de Admissao","Área","Gestor"];
    
    $scope.exportType = function (type){
        exportService.exportType(type,columns);
        window.open("export/exportFile" + "/" + type + "/" + columns);
        
        
    };
});