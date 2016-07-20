<%-- 
    Document   : cadastrar-funcionario
    Created on : 21/06/2016, 22:11:43
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
        <script src="<c:url value="resources/angularjs/module/module.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/resources/angularjs/controller/cadastrarFuncionarioController.js"/>" type="text/javascript"></script>
        <script src="resources/angularjs/controller/modalCertificacaoController.js" type="text/javascript"></script>
        <script src="resources/angularjs/controller/alertController.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/ui-bootstrap-tpls-1.3.3.js" type="text/javascript"></script>

        <script src="resources/angularjs/services/restService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/crudService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/crudCertificacoesService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/broadCastService.js" type="text/javascript"></script>

        <script src="resources/angularjs/directive/searchCertificacoes.js" type="text/javascript"></script>
        <script src="resources/js/datepicker/datepicker.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap-datepicker.pt-BR.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/dirPagination.js" type="text/javascript"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

        <link href="resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/estilo.css" rel="stylesheet" type="text/css"/>
        <style>
            body{
                background-image: url("resources/imgs/blue-light.jpg");
                background-repeat: no-repeat; 
                background-size: 1641px;
            }
            #certificacao{
                position: relative;
                top: 0px;
                border-radius: 50px;
            }
            span.glyphicon-ok{
                color: green;
            }
             #novo{
                margin-top: 15px;
                margin-left: 15px;
            }
        </style>
    </head>
    <body ng-controller="CadastrarFuncionario">
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
            <ul class="nav nav-tabs">
                <li ng-repeat="op in options"><a href="#" ng-click="ativarForm($index)">{{op}}</a></li>
            </ul>
            <div class="panel panel-default" ng-show="booleanForm">
                
                <div class="panel-header"><button class="btn btn-primary" id="novo" ng-show="optionsBoolean[1] || optionsBoolean[2] || optionsBoolean[3]">+</button>
                </div>
                <div class="panel-body">
                    <form class="form-group" ng-show="optionsBoolean[0]">
                        <div class="form-group">
                            <label class="fieldsFuncionarios">Nome</label>
                            <input type="text" class="form-control" ng-model="funcionario.nome"/>
                            <label class="fieldsFuncionarios">Cargo</label>
                            <input type="text" class="form-control" ng-model="funcionario.cargo"/>
                        </div>
                        <div class="form-group">
                            <label class="fieldsFuncionarios">Data de Admissão</label>                            
                            <div class='input-group date' id='datetimepicker2'>
                                <input type="text" class="form-control" ng-model="funcionario.dtAdmissao"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                            <label class="fieldsFuncionarios">Área</label>
                            <input type="text" class="form-control" ng-model="funcionario.area"/><br>
                            <label class="fieldsFuncionarios">Gestor</label>
                            <input type="text" class="form-control" ng-model="funcionario.gestor"/><br>
                        </div>
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[1]">
                        <div class="form-group">
                            <label class="fieldsFuncionarios">Curso</label>
                            <input type="text" class="form-control" ng-model="funcionario.formacoes.curso"/>
                            <label class="fieldsFuncionarios">Instituição</label>
                            <input type="text" class="form-control" ng-model="funcionario.formacoes.instituicao"/>

                            <label class="fieldsFuncionarios">Cópia de Certificado</label>
                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaFormacao('Sim')">Sim</label>
                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaFormacao('Não')">Não</label>
                        </div>                   
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[2]">
                        <div class="form-group">
                            <label class="fieldsFuncionarios">Idioma</label>
                            <select class="form-control" id="sel1" ng-model="funcionario.idiomas.nome">
                                <option  ng-repeat="language in languages">{{language}}</option>

                            </select>
                            <label class="fieldsFuncionarios">Nível</label>
                            <select class="form-control" id="sel1" ng-model="funcionario.idiomas.nivel">
                                <option  ng-repeat="nivel in niveis">{{nivel}}</option>

                            </select>
                        </div>                   
                    </form>
                    
                    <form class="form-group" ng-show="optionsBoolean[3]">
                        <div class="form-group">
                            <label class="fieldsFuncionarios">Certificadora</label>
                            <input type="text" class="form-control" ng-model="funcionario.certificacao.nome"/>
                            <label class="fieldsFuncionarios">Exame</label>
                            <input type="text" class="form-control" ng-model="funcionario.certificacao.empresa"/>
                            <label class="fieldsFuncionarios">Código</label>
                            <input type="text" class="form-control" ng-model="funcionario.certificacao.codigo"/>
                            <label class="fieldsFuncionarios">Data do Exame</label>                            
                            <div class='input-group date' id='datetimepicker3'>
                                <input type="text" class="form-control" ng-model="funcionario.certificacao.dtExame"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                            <label class="fieldsFuncionarios">Validade do Exame</label>                            
                            <div class='input-group date' id='datetimepicker4'>
                                <input type="text" class="form-control" ng-model="funcionario.certificacao.dtValidade"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                            <label class="fieldsFuncionarios">Cópia de Certificado</label>
                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaCertificacao('Sim')">Sim</label>
                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaCertificacao('Não')">Não</label>

                        </div>                   
                    </form>
                    <button class="btn btn-primary btn-block" ng-click="save()">Salvar</button>
                    <button class="btn btn-danger btn-block" ng-click="reset()">Cancel</button>
                </div>
            </div>
        </section>
    </body>
</html>
