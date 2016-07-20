/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var app = angular.module("rhApp");

app.constant("searchById", "crud/searchById"),
        app.constant("searchByNome", "crud/searchByNome"),
        app.constant("search", "crud/search"),
        app.constant("searchFast", "crud/searchForPagination"),
        app.constant("remove", "crud/remove"),
        app.constant("save", "crud/save").factory("crudService", function ($http, searchByNome, searchById, save, search, remove, restService, $uibModal) {





    function openModalOneOneStrongEntity(scope) {
        scope.openModalOneOneStrongEntity = function (size,choosenId,certificacoes) {
            var modalInstance = $uibModal.open({
                animation: true,
                backdrop: 'static',
                templateUrl: 'modalTemplate.jsp',
                controller: 'CadastrarFuncionario',
                size: size,
                resolve: {
                    choosenId: function () {
                        return choosenId;
                    },
                    certificacoes: function () {
                        return certificacoes;
                    }
                }
            });
        };
    }

    return {
        searchById: function (id) {
            var ajaxget = $http({
                url: searchById + "/" + id,
                method: 'GET',
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
            return ajaxget;
        },
        searchByNome: function (nome) {
            var ajaxget = $http({
                url: searchByNome + "/" + nome,
                method: 'GET',
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
            return ajaxget;
        },
        save: function (obj) {
            var ajax = $http({
                url: save,
                method: "POST",
                data: JSON.stringify(obj),
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
        },
        remove: function (obj) {
            var ajax = $http({
                url: remove,
                method: "POST",
                data: JSON.stringify(obj),
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
        },
        search: function () {
            var ajax = $http({
                url: search,
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

            restService.fireGetSuccFail(search + "/" + pageNumber + "/" + pageSize, {filter: filter}, success, failure);
        },
        openModalOneOneStrongEntity: function (scope) {
            openModalOneOneStrongEntity(scope);
        }

    };
});
