/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var app = angular.module("rhApp");
app.controller("alertController", function ($scope, broadCastService) {
    $scope.alerts = [];

    $scope.$on("broadCastAlert", function (event, args) {
        $scope.addAlert(args.type, args.msg);
    });
    $scope.$on("broadCastRemoveAlerts", function (event, args) {
        $scope.alerts = [];
    });

    $scope.addAlert = function (type, msg) {
        $scope.alerts.push({type: type, msg: msg});
    };

    $scope.closeAlert = function (index) {
        $scope.alerts.splice(index, 1);
    };
    $scope.removeAllAlerts = function () {
        $scope.alerts = [];
    };
});