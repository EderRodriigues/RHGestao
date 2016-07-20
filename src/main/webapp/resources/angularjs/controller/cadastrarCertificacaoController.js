/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.controller("cadastrarCertificacaoController", function ($scope, crudCertificacoesService, broadCastService) {
    $scope.certificacao;


    $scope.save = function () {
        if($scope.certificacao === undefined){
            broadCastService.broadCastAlertDanger("Informação inválida");
        }
        if ($scope.certificacao.idCertificacao === null || $scope.certificacao.idCertificacao === undefined) {
            $scope.certificacao.idCertificacao = 0;
            console.log($scope.certificacao);
        }
        if (validation($scope.certificacao)) {
            console.log("Ok");
          var ajax = crudCertificacoesService.salvar($scope.certificacao);
          broadCastService.broadCastAlertSuccess("Salvo com Sucesso");          

        } else {
            console.log("Not Ok");
            broadCastService.broadCastAlertDanger("Informação inválida");
        }
    };


    function validation(certificacao) {
        console.log(certificacao);
        var boolean = true;

        if (certificacao.nome === null || certificacao.nome === undefined || certificacao.nome === "") {
            boolean = false;
        }
        if (certificacao.empresa === null || certificacao.empresa === undefined || certificacao.empresa === "") {
            boolean = false;
        }

        return boolean;
    }
});
