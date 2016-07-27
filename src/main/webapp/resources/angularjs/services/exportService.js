/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");

app.constant("exportType", "export/exportFile").factory("exportService", function ($http, exportType) {

    return{
        exportType: function (type, columns) {
            var ajaxget = $http({
                url: exportType + "/" + type + "/" + columns,
                method: 'POST',
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
            return ajaxget;
        }
    };

});

