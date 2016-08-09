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
        <title>Gestão de RH</title>
        <link rel="shortcut icon" href="resources/imgs/Telesul.png" type="image/x-icon"/>
        <script src="resources/jquery/jquery-2.1.4.js" type="text/javascript"></script>

        <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
        <script src="<c:url value="resources/angularjs/external/angular.js"/>" type="text/javascript"></script>
        <script src="<c:url value="resources/angularjs/module/module.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/resources/angularjs/controller/cadastrarFuncionarioController.js"/>" type="text/javascript"></script>

        <script src="resources/angularjs/controller/alertController.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/ui-bootstrap-tpls-1.3.3.js" type="text/javascript"></script>

        <script src="resources/angularjs/services/restService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/crudService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/exportService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/broadCastService.js" type="text/javascript"></script>
        <script src="resources/js/datepicker/datepicker.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap-datepicker.pt-BR.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/dirPagination.js" type="text/javascript"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

        <link href="resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/estilo.css" rel="stylesheet" type="text/css"/>
        <style>
            body{
                background-image: url("resources/imgs/fabric-of-squares.png");
                background-repeat: repeat;
            }
        </style>
    </head>
    <body ng-controller="CadastrarFuncionario">
        <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index"><img id="banner" src="resources/imgs/LogoTelesul.png"></a>
                </div>
                <ul class="nav navbar-nav">

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="index" id="title">Funcionários
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a class="op" href="cadastrarFuncionario">Cadastrar</a></li>
                            <li><a class="op" href="atualizarFuncionario">Atualizar</a></li>
                        </ul>
                    </li>
                    <li class="dropdown" id="setor">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="index">Gestão de RH
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <section class="">
            <div ng-controller="alertController" id="allalerts">
                <uib-alert class="alert-success" ng-show="alert.type === 'success'"  ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</uib-alert>
                <uib-alert class="alert-danger" ng-show="alert.type === 'danger'"  ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</uib-alert>
            </div>
            <ul class="nav nav-tabs">
                <li id="tabs" ng-class="indexColor === $index ? 'active' : 'none'" ng-click="applyClass(op, $index)" ng-repeat="op in options"><a href="#" ng-click="ativarForm($index)">{{op}}</a></li>
            </ul>
            <div class="panel panel-default" ng-show="booleanForm">


                <div class="panel-body">
                    <form class="form-group" ng-show="optionsBoolean[0]">
                        <h4>Dados Cadastrais</h4>
                        <div class="border">
                            <div class="form-group">
                                <label>Nome</label>
                                <input type="text" class="form-control" ng-model="funcionario.nome"/>                           
                            </div>
                            <div class="row">
                                <div class="col-sm-3"><label>Cargo</label></div>
                                <div class="col-sm-3"><label>Data de Admissão</label></div>                                    
                                <div class="col-sm-3"><label>Área</label></div>  
                                <div class="col-sm-3">
                                    <label>Gestor</label>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" ng-model="funcionario.cargo"/>
                                </div>
                                <div class="col-sm-3">
                                    <div class='input-group date dtpicker' data-provide="datepicker">
                                        <input type="text" class="form-control" ng-model="funcionario.dtAdmissao"/>
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-3"> <input type="text" class="form-control" ng-model="funcionario.area"/></div>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" ng-model="funcionario.gestor"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <label>Email</label>
                                </div>
                                <div class="col-sm-3">
                                    <label>Telefone</label>
                                </div>
                                <div class="col-sm-3">
                                    <label>Celular</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <input type="email" class="form-control" ng-model="funcionario.email">
                                </div>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" ng-model="funcionario.telefone">
                                </div>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" ng-model="funcionario.celular">
                                </div>
                            </div>
                            <br>
                            <div ng-include="'saveBottomsTemplate'">

                            </div>

                        </div>
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[1]">
                        <div class="panel-body">
                            <h4>Formação</h4>
                            <div class="border"><br>
                                <table class="table table-condensed">
                                    <thead class="headerTable">
                                        <tr>
                                            <th>Nível</th>
                                            <th>Curso</th>
                                            <th>Instituição</th>
                                            <th>Cópia de Certificado</th>
                                            <th>Ação</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="formacao in funcionario.formacoes">
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.nivel" ng-hide="funcionario.checked">

                                                <select class="form-control" ng-model="formacao.nivel" ng-show="funcionario.checked">
                                                    <option>Técnico</option>
                                                    <option>Superior Incompleto</option>
                                                    <option>Superior Completo</option>
                                                    <option>Pós Graduado</option>
                                                    <option>Mestrado</option>
                                                    <option>Doutorado</option>
                                                </select>

                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.curso" ng-hide="funcionario.checked">
                                                <input type="text" class="form-control" ng-model="formacao.curso" ng-show="funcionario.checked">

                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.instituicao" ng-hide="funcionario.checked">
                                                <input type="text" class="form-control"  ng-model="formacao.instituicao" ng-show="funcionario.checked">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.copiaCertificado" ng-hide="funcionario.checked">
                                                <select class="form-control" ng-model="formacao.copiaCertificado" ng-show="funcionario.checked">
                                                    <option>Sim</option>
                                                    <option>Não</option>
                                                </select>

                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow('formacao')" ng-hide="funcionario.checked">Editar</button>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow('formacao')" ng-show="funcionario.checked">Salvar</button>
                                                <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'formacao')">Remover</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <select class="form-control" ng-model="newFormacoes.nivel">
                                                    <option>Técnico</option>
                                                    <option>Superior Incompleto</option>
                                                    <option>Superior Completo</option>
                                                    <option>Pós Graduado</option>
                                                    <option>Mestrado</option>
                                                    <option>Doutorado</option>
                                                </select>

                                            </td>
                                            <td>
                                                <input type="text" class="form-control" ng-model="newFormacoes.curso">

                                            </td>
                                            <td>
                                                <input type="text" class="form-control" ng-model="newFormacoes.instituicao">
                                            </td>
                                            <td>
                                                <select class="form-control" ng-model="newFormacoes.copiaCertificado">
                                                    <option>Sim</option>
                                                    <option>Não</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="addRow(newFormacoes, 'formacao')">Adicionar</button>
                                                <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="cancelRow('formacao')">Cancelar</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table><br>
                                <div ng-include="'saveBottomsTemplate'">

                                </div>
                            </div>
                        </div>                 
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[2]">
                        <div class="panel-body">
                            <h4>Idiomas</h4>
                            <div class="border"><br>
                                <table class="table table-condensed">
                                    <thead class="headerTable">
                                        <tr>
                                            <th>Idioma</th>
                                            <th>Nivel</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="idioma in funcionario.idiomas">
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="idioma.nome" ng-hide="funcionario.checked">
                                                <select class="form-control" id="sel1" ng-model="idioma.nome" ng-show="funcionario.checked">
                                                    <option  ng-repeat="language in languages">{{language}}</option>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="idioma.nivel" ng-hide="funcionario.checked">
                                                <select class="form-control" id="sel1" ng-model="idioma.nivel" ng-show="funcionario.checked">
                                                    <option  ng-repeat="nivel in niveis">{{nivel}}</option>
                                                </select>

                                            </td>

                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="funcionario.checked">Editar</button>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow(formacao)" ng-show="funcionario.checked">Salvar</button>
                                                <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'idioma')">Remover</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <select class="form-control" id="sel1" ng-model="novoIdioma.nome">
                                                    <option  ng-repeat="language in languages">{{language}}</option>
                                                </select>

                                            </td>
                                            <td>
                                                <select class="form-control" id="sel1" ng-model="novoIdioma.nivel">
                                                    <option  ng-repeat="nivel in niveis">{{nivel}}</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="addRow(novoIdioma, 'idioma')">Adicionar</button>
                                                <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="cancelRow('idiomas')">Cancelar</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table><br>
                                <div ng-include="'saveBottomsTemplate'">

                                </div>
                            </div>
                        </div>                 
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[3]">
                        <div class="panel-body">
                            <h4 ng-hide="funcionario.certificacoes.length > 0">Certificação</h4>
                            <div class="border">
                                <h4 ng-show="funcionario.certificacoes.length > 0">Certificação</h4>
                                <div class="border" ng-repeat="certificacao in funcionario.certificacoes">
                                    <h4>{{certificacao.nome}}</h4>
                                    <div class="row">
                                        <div class="col-sm-2"><label>Código</label></div>
                                        <div class="col-sm-3"><label>Certificadora</label></div>
                                        <div class="col-sm-3"><label>Exame</label></div>

                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2"> 
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.codigo" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control"  ng-model="certificacao.codigo" ng-show="funcionario.checked">
                                        </div>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.empresa" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control"  ng-model="certificacao.empresa" ng-show="funcionario.checked">
                                        </div>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.nome" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control" ng-model="certificacao.nome" ng-show="funcionario.checked">
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3"><label>Data de Exame</label></div>
                                        <div class="col-sm-3"><label>Data Validade</label></div>
                                        <div class="col-sm-3"><label>Cópia</label></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.dtExame" ng-hide="funcionario.checked">
                                            <div class='input-group date dtpicker' data-provide="datepicker" ng-show="funcionario.checked">
                                                <input type="text" class="form-control" ng-model="certificacao.dtExame"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.dtValidade" ng-hide="funcionario.checked">
                                            <div class='input-group date dtpicker' data-provide="datepicker" ng-show="funcionario.checked">
                                                <input type="text" class="form-control" ng-model="certificacao.dtValidade"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.copia" ng-hide="funcionario.checked">
                                            <select class="form-control" ng-model="certificacao.copia" ng-show="funcionario.checked">
                                                <option>Sim</option>
                                                <option>Não</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3">
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow()" ng-show="funcionario.checked">Salvar</button>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="funcionario.checked">Editar</button>
                                            <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'certificacao')">Remover</button>
                                        </div>
                                        <br>

                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-sm-2"><label>Código</label></div>
                                    <div class="col-sm-3"><label>Certificadora</label></div>
                                    <div class="col-sm-3"><label>Exame</label></div>

                                </div>
                                <div class="row">
                                    <div class="col-sm-2"><input type="text" class="form-control" ng-model="newCertificacoes.codigo"></div>
                                    <div class="col-sm-3"><input type="text" class="form-control" ng-model="newCertificacoes.empresa"></div>
                                    <div class="col-sm-6"><input type="text" class="form-control" ng-model="newCertificacoes.nome"></div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3"><label>Data Exame</label></div>
                                    <div class="col-sm-3"><label>Data Validade</label></div>
                                    <div class="col-sm-3"><label>Cópia</label></div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class='input-group date dtpicker' data-provide="datepicker">
                                            <input type="text" class="form-control" ng-model="newCertificacoes.dtExame"/>
                                            <div class="input-group-addon">
                                                <div class="glyphicon glyphicon-calendar"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class='input-group date dtpicker' data-provide="datepicker">
                                            <input type="text" class="form-control" ng-model="newCertificacoes.dtValidade"/>
                                            <div class="input-group-addon">
                                                <div class="glyphicon glyphicon-calendar"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <select class="form-control" ng-model="newCertificacoes.copia">
                                            <option>Sim</option>
                                            <option>Não</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                        <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="addRow(newCertificacoes, 'certificacao')">Adicionar</button>
                                        <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="cancelRow('certificacao')">Cancelar</button>    
                                    </div>
                                </div><br>
                                <div ng-include="'saveBottomsTemplate'">

                                </div>
                            </div>
                        </div>   
                    </form>


                </div>
            </div>
        </section>
    </body>
</html>
