/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.controller("atualizarFuncionario", function ($scope, crudService, crudCertificacoesService, $uibModal, broadCastService) {
    $scope.funcionarios;
    $scope.selecionado;
    $scope.options = ["Dados Cadastrais", "Formação Acadêmica", "Idioma", "Certificação"];
    $scope.optionsBoolean = [false, false, false, false];
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
    $scope.isEmployeeSelected = function (employee) {
        $("#loader").show();
        console.log("employee");
        console.log(employee);
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
//    $scope.removeCertification = function (certification) {
//        var boolean = confirm("Deseja excluir?");
//        if (boolean) {
//            angular.forEach($scope.selecionado.certificacoes, function (value, index) {
//                if (certification.nome === value.nome) {
//                    $scope.selecionado.certificacoes.splice([index], 1);
//                    console.log("$scope.selecionado.certificacoes");
//                    console.log($scope.selecionado.certificacoes);
//
//                }
//            });
//        }
//    };
//
//    $scope.addCertificados = function (size, certificatesSelecionadas) {
//        console.log($scope.certificacoes);
//        angular.forEach($scope.certificacoes, function (value, index) {
//            console.log("value.checked");
//            for (var i = 0; i < certificatesSelecionadas.length; i++) {
//                if (value.nome === certificatesSelecionadas[i].nome) {
//                    if (!value.checked === true) {
//                        $scope.certificacoes[index].checked = !$scope.certificacoes[index].checked;
//                        console.log($scope.certificacoes[index].checked);
//                    }
//
//                }
//            }
//
//        });
//        var modalInstance = $uibModal.open({
//            animation: true,
//            templateUrl: 'modalTemplate',
//            controller: 'modalCertificacaoController',
//            size: size,
//            resolve: {
//                certificacoes: function () {
//                    return $scope.certificacoes;
//                },
//                certificatesSelecionadas: function () {
//                    return certificatesSelecionadas;
//                }
//            }
//        });
//        modalInstance.result.then(function (selectedItem) {
//            console.log(selectedItem);
//            if (selectedItem[0] === undefined) {
//                angular.forEach($scope.selecionado.certificacoes, function (value, index) {
//                    $scope.selecionado.certificacoes.splice(index, $scope.selecionado.certificacoes.length);
//                });
//
//
//            } else {
//                if (angular.isUndefined($scope.selecionado.certificacoes[0])) {
//                    for (var i = 0; i < selectedItem.length; i++) {
//                        $scope.selecionado.certificacoes.push(selectedItem[i]);
//                    }
//
//                } else {
//
//                    for (var i = 0; i < selectedItem.length; i++) {
//                        var cont = 0;
//                        for (var j = 0; j < $scope.selecionado.certificacoes.length; j++) {
//                            if ($scope.selecionado.certificacoes[j].nome === selectedItem[i].nome) {
//                                cont++;
////                            $scope.selecionado.certificacoes.splice([j], 1);
//                            }
//                        }
//                        if (cont === 0) {
//                            $scope.selecionado.certificacoes.push(selectedItem[i]);
//                        }
//                    }
//
//                    for (var i = 0; i < $scope.selecionado.certificacoes.length; i++) {
//                        var boolean = false;
//                        for (var j = 0; j < selectedItem.length; j++) {
//                            if ($scope.selecionado.certificacoes[i].nome === selectedItem[j].nome) {
//                                boolean = true;
//                            }
//                        }
//                        if (!boolean) {
//                            $scope.selecionado.certificacoes.splice([i], 1);
//                        }
//                    }
//                }

//                if (cont !== selectedItem.length) {
//                    angular.forEach($scope.selecionado.certificacoes, function (value, index) {
//                        var boolean = true;
//                        for (var i = 0; i < selectedItem.length; i++) {
//
//                            if (value.nome === selectedItem[i].nome) {
//                                boolean = false;
//                            }
//                        }
//                        if (boolean) {
//                            $scope.selecionado.certificacoes.splice([index], 1);
//                        }
//                    });
//                }
//            }
//
//
//
//
//            console.log($scope.selecionado.certificacoes);
//
//        });
//    };

//function searchCertifications() {
//        var ajaxget = crudCertificacoesService.searchCertificacoes();
//        ajaxget.success(function (data) {
//            console.log(data);
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