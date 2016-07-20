/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.factory("broadCastService", function ($rootScope) {
    function broadCastAlert(type, msg) {
        $rootScope.$broadcast("broadCastAlert", {
            type: type, msg: msg
        });
    }
    function broadCastRemoveAlerts() {
        $rootScope.$broadcast("broadCastRemoveAlerts", {});
    }
    return{
        broadCastAlertSuccess: function (msg) {
            broadCastAlert('success', msg);
        },
        broadCastAlertDanger: function (msg) {
            broadCastAlert('danger', msg);
        },
        broadCastAlertRemove: function (msg) {
            broadCastAlert('remove', msg);
        },
        broadCastAlertUpdate: function (msg) {
            broadCastAlert('update', msg);
        }
    };
});