<%-- 
    Document   : atualizarCertificacao
    Created on : 09/07/2016, 17:10:37
    Author     : Eder Rodrigues
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="rhApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RH Gestão</title>
        <script src="resources/jquery/jquery-2.1.4.js" type="text/javascript"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
        <script src="<c:url value="resources/angularjs/external/angular.js"/>" type="text/javascript"></script>
        <script src="resources/angularjs/module/module.js" type="text/javascript"></script>
        <script src="resources/angularjs/controller/atualizarCertificacaoController.js" type="text/javascript"></script>
        <script src="resources/angularjs/controller/alertController.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/ui-bootstrap-tpls-1.3.3.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>

        <script src="resources/angularjs/services/restService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/crudService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/crudCertificacoesService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/broadCastService.js" type="text/javascript"></script>
        <script src="resources/js/datepicker/datepicker.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap-datepicker.pt-BR.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/dirPagination.js" type="text/javascript"></script>
        <script src="resources/angularjs/directive/searchAllCertificates.js" type="text/javascript"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

        <link href="resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/estilo.css" rel="stylesheet" type="text/css"/>
    </head>
    <style>
        body{
            background-image: url("resources/imgs/blue-light.jpg");
            background-repeat: no-repeat; 
            background-size: 1600px;

        }
        #loader{
            z-index: 1;
            margin-top: -50px;
            margin-left: 650px;
            height: 40px;
            width: 40%;
        }
        img{
            height: 100px;
            width: 100px;
        }
    </style>
    <body ng-controller="atualizarCertificacaoController">
        <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index"><img id="img" src="resources/imgs/Telesul.png"></a>
                </div>
                <ul class="nav navbar-nav">

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="index">Funcionários
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a class="op" href="cadastrarFuncionario">Cadastrar</a></li>
                            <li><a class="op" href="atualizarFuncionario">Atualizar</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Certificações
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a class="op" href="cadastrarCertificacao">Cadastrar</a></li>
                            <li><a class="op" href="atualizarCertificacao">Atualizar</a></li>
                        </ul>
                    </li>

                </ul>
            </div>
        </nav>

        <section class="container">
            <div ng-controller="alertController" id="allalerts">
                <uib-alert id="msgSuccess" ng-show="alert.type === 'success'"  ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</uib-alert>
                <uib-alert id="msgError" ng-show="alert.type === 'danger'"  ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</uib-alert>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3>Certificações</h3>
                </div>
                <div class="panel panel-body" id="atualizarFuncionario">
                    <form class="formulario">

                        <div search-all-certificates></div>
                        <div ng-show="selecionado" >
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nome</th>
                                        <th>Empresa</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th><input class="form-control" ng-model="selecionado.id"/></th>
                                        <th><input class="form-control" ng-model="selecionado.nome"/></th>                                
                                        <th><input class="form-control" ng-model="selecionado.empresa"/></th>
                                    </tr>
                                </tbody>
                            </table>
                            <button class="btn btn-primary" ng-click="save(selecionado)">Salvar</button>
                            <button class="btn btn-danger" ng-click="remove(selecionado)">Deletar</button><br><br><br>
                        </div>

                    </form>
                </div>
            </div>
        </section>
        <div id="loader">
            <img src="resources/imgs/loader4.gif" class="ajax-loader"/>
        </div>
    </body>
</html>
