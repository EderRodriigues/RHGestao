/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

angular.module("rhApp")
        .factory("restService", function ($http) {
            var token = $("meta[name='_csrf']").attr("content");

            return{
                fireGetSuccFail: function (url, params, success, failure) {
                    $http({
                        url: url,
                        method: 'GET',
                        async: true,
                        cache: false,
                        headers: {'Accept': 'application/json;charset=UTF-8', 'Pragma': 'no-cache', 'X-CSRF-TOKEN': token},
                        params: params
                    }).success(function (data) {
                        success(data);
                    }).error(function (error, status) {
                        failure(error);
                    }).finally(function () {
                    }).catch(function (error) {
                    });
                }
            };
});
