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
            /*body{
                background-image: url("resources/imgs/blue-light.jpg");
                background-repeat: no-repeat; 
                background-size: 1641px;
            }*/
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
                <li ng-class="indexColor === $index ? 'active' : 'none'" ng-click="applyClass(op, $index)" ng-repeat="op in options"><a href="#" ng-click="ativarForm($index)">{{op}}</a></li>
            </ul>
            <div class="panel panel-default" ng-show="booleanForm">

                <div class="panel-header">
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
                            <div class='input-group date dtpicker' data-provide="datepicker">
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
                        <div class="panel-body">
                            <table class="table table-condensed">
                                <thead>
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
                                            <input type="text" class="form-control" ng-model="formacao.nivel" ng-show="funcionario.checked">

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
                                            <input type="text" class="form-control" ng-model="formacao.copiaCertificado" ng-show="funcionario.checked">

                                        </td>
                                        <td>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="funcionario.checked">Edit</button>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow()" ng-show="funcionario.checked">Save</button>
                                            <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'formacao')">Remove</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="text" class="form-control" ng-model="newFormacoes.nivel">

                                        </td>
                                        <td>
                                            <input type="text" class="form-control" ng-model="newFormacoes.curso">

                                        </td>
                                        <td>
                                            <input type="text" class="form-control" ng-model="newFormacoes.instituicao">
                                        </td>
                                        <td>
                                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaFormacao('Sim')">Sim</label>
                                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaFormacao('Não')">Não</label>
                                        </td>
                                        <td>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="addRow(newFormacoes, 'formacao')">Adicionar</button>
                                            <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow()">Cancel</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>                 
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[2]">

                        <div class="panel-body">
                            <table class="table table-condensed">
                                <thead>
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
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="funcionario.checked">Edit</button>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow(formacao)" ng-show="funcionario.checked">Save</button>
                                            <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'idioma')">Remove</button>
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
                                            <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow()">Cancel</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>                 
                    </form>
                    <form class="form-group" ng-show="optionsBoolean[3]">
                        <div class="panel-body">
                            <table class="table table-condensed">
                                <thead>
                                    <tr>
                                        <th>Certificadora</th>
                                        <th>Exame</th>
                                        <th>Codigo</th>
                                        <th>Data Exame</th>
                                        <th>Validade Exame</th>
                                        <th>Cópia de Certificado</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="certificacao in funcionario.certificacoes">
                                        <td>
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.nome" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control" ng-model="certificacao.nome" ng-show="funcionario.checked">

                                        </td>
                                        <td>
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.empresa" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control"  ng-model="certificacao.empresa" ng-show="funcionario.checked">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.codigo" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control"  ng-model="certificacao.codigo" ng-show="funcionario.checked">
                                        </td>
                                        <td>                                            
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.dtExame" ng-hide="funcionario.checked">
                                            <div class='input-group date dtpicker' data-provide="datepicker" ng-show="funcionario.checked">
                                                <input type="text" class="form-control" ng-model="certificacao.dtExame"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </td>
                                        <td>              
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.dtValidade" ng-hide="funcionario.checked">
                                            <div class='input-group date dtpicker' data-provide="datepicker" ng-show="funcionario.checked">
                                                <input type="text" class="form-control" ng-model="certificacao.dtValidade"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" readonly="true" ng-model="certificacao.copia" ng-hide="funcionario.checked">
                                            <input type="text" class="form-control" ng-model="certificacao.copia" ng-show="funcionario.checked">

                                        </td>
                                        <td>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow()" ng-show="funcionario.checked">Save</button>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="funcionario.checked">Editar</button>
                                        </td>
                                        <td>
                                            <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'certificacao')">Remove</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="text" class="form-control sizeInput" ng-model="newCertificacoes.nome">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control sizeInput" ng-model="newCertificacoes.empresa">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control sizeInput" ng-model="newCertificacoes.codigo">
                                        </td>
                                        <td>
                                            <div class='input-group date dtpicker' data-provide="datepicker">
                                                <input type="text" class="form-control" ng-model="newCertificacoes.dtExame"/>
                                                <div class="input-group-addon">
                                                    <div class="glyphicon glyphicon-calendar"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class='input-group date dtpicker' data-provide="datepicker">
                                                <input type="text" class="form-control" ng-model="newCertificacoes.dtValidade"/>
                                                <div class="input-group-addon">
                                                    <div class="glyphicon glyphicon-calendar"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaCertificacao('Sim')">Sim</label>
                                            <label class="radio-inline" id="radio2"><input type="radio" name="optradio" ng-click="selectCopiaCertificacao('Não')">Não</label>
                                        </td>
                                        <td>
                                            <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="addRow(newCertificacoes, 'certificacao')">Adicionar</button>
                                        </td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>   
                    </form>

                    <button class="btn btn-primary btn-block" ng-click="save()">Salvar</button>
                    <button class="btn btn-danger btn-block" ng-click="reset()">Cancel</button>
                </div>
            </div>
        </section>
    </body>
</html>
