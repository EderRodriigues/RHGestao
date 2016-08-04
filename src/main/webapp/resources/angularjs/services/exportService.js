/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");

app.constant("exportType", "export/exportFile"),
app.constant("exportSingleReport", "export/exportSingleReport"),
app.constant("readExcel", "export/readExcel").factory("exportService", function ($http, exportType,readExcel,exportSingleReport) {

    return{
        exportType: function (type) {
            var ajaxget = $http({
                url: exportType + "/" + type,
                method: 'GET',
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
           
        },
        readExcel: function () {
            var ajaxget = $http({
                url: readExcel,
                method: 'GET',
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
           
        },
        exportSingleReport: function (id) {
            var ajaxget = $http({
                url: exportSingleReport+"/"+id,
                method: 'GET',
                async: true,
                cache: false,
                headers: {'Accept': 'application/json', 'Pragma': 'no-cache'}
            });
           
        }
    };

});

