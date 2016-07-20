/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var app = angular.module("rhApp");
app.constant("searchCertificacoes", "crudCertificacoes/search"),
        app.constant("salvar", "crudCertificacoes/salvar"),
        app.constant("searchFast", "crudCertificacoes/searchForPagination"),
        app.constant("deletar", "crudCertificacoes/deletar")
        .factory("crudCertificacoesService", function ($http, searchCertificacoes, restService, salvar,deletar) {
            return{
                searchCertificacoes: function () {
                    var ajax = $http({
                        url: searchCertificacoes,
                        method: "GET",
                        async: true,
                        cache: false,
                        headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
                    });
                    return ajax;
                },
                searchFast: function (pageNumber, pageSize, filter, success, failure) {
                    if (angular.isUndefined(pageNumber))
                        pageNumber = 1;
                    if (angular.isUndefined(pageSize))
                        pageSize = 1;

                    restService.fireGetSuccFail(searchCertificacoes + "/" + pageNumber + "/" + pageSize, {filter: filter}, success, failure);
                },
                salvar: function (obj) {
                    var ajax = $http({
                        url: salvar,
                        method: "POST",
                        data: JSON.stringify(obj),
                        async: true,
                        cache: false,
                        headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
                    });
                },
                deletar: function (obj) {
                    var ajax = $http({
                        url: deletar,
                        method: "POST",
                        data: JSON.stringify(obj),
                        async: true,
                        cache: false,
                        headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
                    });
                }
            };
        });
