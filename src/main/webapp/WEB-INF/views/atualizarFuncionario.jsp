<%-- 
    Document   : atualizar-funcionario
    Created on : 23/06/2016, 20:18:38
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
        <script src="resources/angularjs/controller/atualizarFuncionarioController.js" type="text/javascript"></script>
        <script src="resources/angularjs/controller/modalCertificacaoController.js" type="text/javascript"></script>
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
        <script src="resources/angularjs/directive/search.js" type="text/javascript"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

        <link href="resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/estilo.css" rel="stylesheet" type="text/css"/>
        <style>
            body{
                background-image: url("resources/imgs/blue-light.jpg");
                background-repeat: no-repeat; 
                background-size: 1920px;
            }
            #dtNasc{
                width: 30%;
            }
            .form-control{

            }
            #add{
                top: 10px;
                left: 30px;
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
    </head>
    <body ng-controller="atualizarFuncionario">
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
                    <h3>Funcionário</h3>
                </div>
                <div class="panel panel-body" id="atualizarFuncionario">
                    <form class="formulario">

                        <div search></div>
                        <div ng-show="selecionado">
                            <ul class="nav nav-tabs">
                                <li ng-repeat="op in options"><a href="#" ng-click="ativarForm($index)">{{op}}</a></li>
                            </ul>
                            <div ng-show="optionsBoolean[0]">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nome</th>
                                            <th>Cargo</th>
                                            <th>Area</th>                                       
                                            <th>Data de Admissão</th>                                       
                                            <th>Gestor</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th><input class="form-control" ng-model="selecionado.idFuncionario"/></th>
                                            <th><input class="form-control" ng-model="selecionado.nome"/></th>                                
                                            <th><input class="form-control" ng-model="selecionado.cargo"/></th>
                                            <th><input class="form-control" ng-model="selecionado.area"/></th>
                                            <th id="dtNasc">  
                                                <div class='input-group date' id='datetimepicker3'>
                                                    <input type="text" class="form-control" ng-model="selecionado.dtAdmissao"/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </th>
                                            <th><input class="form-control" ng-model="selecionado.gestor"/></th>
                                            <!--<th><a href="#" ng-click="addCertificados('lg', selecionado.certificacoes)"><span id="add" class="glyphicon glyphicon-plus"></span></a></th>-->
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[1]">
                                <table>
                                    <thead>
                                        <th>Nome/Curso</th>
                                        <th>Instituicao</th>
                                        <th>Copia Certificado</th>                                        
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="cert in selecionado.formacoes">
                                            <th>{{cert.nome}}</th>
                                            <th>{{cert.instituicao}}</th>
                                            <th>{{cert.copiaCertificado}}</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[2]">
                                <table>
                                    <thead>
                                        <th>Idioma</th>
                                        <th>Nível</th>                                        
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="cert in selecionado.idiomas">
                                            <th>{{cert.nome}}</th>
                                            <th>{{cert.nivel}}</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[3]">
                                <table>
                                    <thead>
                                        <th>Codigo</th>
                                        <th>Nome/Curso</th>
                                        <th>Empresa</th>
                                        <th>Data de Exame/dtExame</th>
                                        <th>Data de Validade/dtValidade</th>
                                        <th>Copia</th>
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="cert in selecionado.certifcacoes">
                                            <th>{{cert.codigo}}</th>
                                            <th>{{cert.nome}}</th>
                                            <th>{{cert.empresa}}</th>
                                            <th>{{cert.dtExame}}</th>
                                            <th>{{cert.dtValidade}}</th>
                                            <th>{{cert.copia}}</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
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
