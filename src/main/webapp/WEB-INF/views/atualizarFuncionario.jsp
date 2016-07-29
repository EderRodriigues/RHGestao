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
        <link rel="shortcut icon" href="resources/imgs/Telesul.png" type="image/x-icon"/>
        <script src="resources/jquery/jquery-2.1.4.js" type="text/javascript"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
        <script src="<c:url value="resources/angularjs/external/angular.js"/>" type="text/javascript"></script>
        <script src="resources/angularjs/module/module.js" type="text/javascript"></script>
        <script src="resources/angularjs/controller/atualizarFuncionarioController.js" type="text/javascript"></script>

        <script src="resources/angularjs/controller/alertController.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/ui-bootstrap-tpls-1.3.3.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>

        <script src="resources/angularjs/services/restService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/crudService.js" type="text/javascript"></script>

        <script src="resources/angularjs/services/broadCastService.js" type="text/javascript"></script>
        <script src="resources/angularjs/services/exportService.js" type="text/javascript"></script>
        <script src="resources/js/datepicker/datepicker.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap-datepicker.pt-BR.js" type="text/javascript"></script>
        <script src="resources/angularjs/external/dirPagination.js" type="text/javascript"></script>
        <script src="resources/angularjs/directive/search.js" type="text/javascript"></script>
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
    <body ng-controller="atualizarFuncionario">
        <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index"><img id="banner" src="resources/imgs/Telesul.png"></a>
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
                </ul>
            </div>
        </nav>
        <section class="container">
            <div ng-controller="alertController" id="allalerts">
                <uib-alert class="alert-success" ng-show="alert.type === 'success'"  ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</uib-alert>
                <uib-alert class="alert-danger" ng-show="alert.type === 'danger'"  ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</uib-alert>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Funcionário</h4>
                </div>
                <div class="panel panel-body" id="atualizarFuncionario">
                    <form class="formulario">

                        <div search></div>
                        <div ng-show="selecionado">
                            <ul class="nav nav-tabs">
                                <li id="tabs" ng-class="indexColor === $index ? 'active' : 'none'" ng-click="applyClass(op, $index)" ng-repeat="op in options"><a href="#" ng-click="ativarForm($index)">{{op}}</a></li>
                            </ul>
                            <div ng-show="optionsBoolean[0]">
                                <table class="table table-condensed table-hover">
                                    <thead class="headerTable">
                                        <tr>
                                            <th>ID</th>
                                            <th>Nome</th>
                                            <th>Cargo</th>
                                            <th>Area</th>                                       
                                            <th>Data de Admissão</th>                                       
                                            <th>Gestor</th>
                                            <th></th>
                                            <th></th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input class="form-control" ng-model="selecionado.idFuncionario"/></td>
                                            <td><input class="form-control" ng-model="selecionado.nome"/></td>                                
                                            <td><input class="form-control" ng-model="selecionado.cargo"/></td>
                                            <td><input class="form-control" ng-model="selecionado.area"/></td>
                                            <td id="dtNasc">  
                                                <div class='input-group date dtpicker'>
                                                    <input type="text" class="form-control" ng-model="selecionado.dtAdmissao"/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </td>
                                            <td><input class="form-control" ng-model="selecionado.gestor"/></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[1]">
                                <table class="table table-hover table-condensed">
                                    <thead class="headerTable">
                                    <th>Nivel</th>
                                    <th>Nome</th>
                                    <th>Instituicao</th>
                                    <th>Copia de Certificação</th>                                        
                                    <th></th>                                        
                                    <th></th>                                        
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="formacao in selecionado.formacoes">
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.nivel" ng-hide="selecionado.checked">
                                                
                                                <select class="form-control" ng-model="formacao.nivel" ng-show="selecionado.checked">
                                                    <option>Técnico</option>
                                                    <option>Superior Incompleto</option>
                                                    <option>Superior Completo</option>
                                                    <option>Pós Graduado</option>
                                                    <option>Mestrado</option>
                                                    <option>Doutorado</option>
                                                </select>

                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.curso" ng-hide="selecionado.checked">
                                                <input type="text" class="form-control" ng-model="formacao.curso" ng-show="selecionado.checked">

                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.instituicao" ng-hide="selecionado.checked">
                                                <input type="text" class="form-control"  ng-model="formacao.instituicao" ng-show="selecionado.checked">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="formacao.copiaCertificado" ng-hide="selecionado.checked">

                                                <select class="form-control" ng-model="formacao.copiaCertificado" ng-show="selecionado.checked">
                                                    <option>Sim</option>
                                                    <option>Não</option>
                                                </select>

                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="selecionado.checked">Editar</button>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow()" ng-show="selecionado.checked">Salvar</button>
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
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[2]">
                                <table class="table table-condensed table-hover">
                                    <thead class="headerTable">
                                    <th>Idioma</th>
                                    <th>Nível</th>                                        
                                    <th></th>                                        
                                    <th></th>                                        
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="idioma in selecionado.idiomas">
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="idioma.nome" ng-hide="selecionado.checked">
                                                <select class="form-control" id="sel1" ng-model="idioma.nome" ng-show="selecionado.checked">
                                                    <option  ng-repeat="language in languages">{{language}}</option>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" readonly="true" ng-model="idioma.nivel" ng-hide="selecionado.checked">
                                                <select class="form-control" id="sel1" ng-model="idioma.nivel" ng-show="selecionado.checked">
                                                    <option  ng-repeat="nivel in niveis">{{nivel}}</option>
                                                </select>

                                            </td>

                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="selecionado.checked">Editar</button>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow(formacao)" ng-show="selecionado.checked">Salvar</button>
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
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[3]">
                                <table class="table table-condensed table-hover">
                                    <thead class="headerTable">
                                    <th>Codigo</th>
                                    <th>Exame</th>
                                    <th>Certificadora</th>
                                    <th>Data de Exame</th>
                                    <th>Data de Validade</th>
                                    <th>Copia de Certificação</th>
                                    <th></th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="certificacao in selecionado.certificacoes">
                                            <td>
                                                <input type="text" class="form-control sizeInput" readonly="true" ng-model="certificacao.codigo" ng-hide="selecionado.checked">
                                                <input type="text" class="form-control sizeInput" ng-model="certificacao.codigo" ng-show="selecionado.checked">

                                            </td>
                                            <td>
                                                <input type="text" class="form-control sizeInput" readonly="true" ng-model="certificacao.empresa" ng-hide="selecionado.checked">
                                                <input type="text" class="form-control sizeInput"  ng-model="certificacao.empresa" ng-show="selecionado.checked">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control sizeInput" readonly="true" ng-model="certificacao.nome" ng-hide="selecionado.checked">
                                                <input type="text" class="form-control sizeInput"  ng-model="certificacao.nome" ng-show="selecionado.checked">
                                            </td>
                                            <td>                                            
                                                <input type="text" class="form-control" readonly="true" ng-model="certificacao.dtExame" ng-hide="selecionado.checked">
                                                <div class='input-group date dtpicker' data-provide="datepicker" ng-show="selecionado.checked">
                                                    <input type="text" class="form-control" ng-model="certificacao.dtExame"/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </td>
                                            <td>              
                                                <input type="text" class="form-control" readonly="true" ng-model="certificacao.dtValidade" ng-hide="selecionado.checked">
                                                <div class='input-group date dtpicker' data-provide="datepicker" ng-show="selecionado.checked">
                                                    <input type="text" class="form-control" ng-model="certificacao.dtValidade"/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </td>
                                            <td>
                                                <input type="text" class="form-control sizeInput" readonly="true" ng-model="certificacao.copia" ng-hide="selecionado.checked">

                                                <select class="form-control" ng-model="certificacao.copia" ng-show="selecionado.checked" ng-show="selecionado.checked">
                                                    <option>Sim</option>
                                                    <option>Não</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="saveRow()" ng-show="selecionado.checked">Salvar</button>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="editRow()" ng-hide="selecionado.checked">Editar</button>
                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="removeRow($index, 'certificacao')">Remover</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="text" class="form-control sizeInput" ng-model="newCertificacoes.codigo">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control sizeInput" ng-model="newCertificacoes.empresa">
                                            </td>
                                            <td>
                                                <input type="text" class="form-control sizeInput" ng-model="newCertificacoes.nome">
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
                                                <!--<label class="radio-inline"><input type="radio" name="optradio" ng-click="selectCopiaCertificacao('Sim')">Sim</label>
                                                <label class="radio-inline" id="radio2"><input type="radio" name="optradio" ng-click="selectCopiaCertificacao('Não')">Não</label>-->
                                                <select class="form-control" id="sel1" ng-model="newCertificacoes.copia">
                                                    <option>Sim</option>
                                                    <option>Não</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-info" class="btn btn-block" ng-click="addRow(newCertificacoes, 'certificacao')">Adicionar</button>
                                                
                                            </td>
                                            <td>
                                                <button type="button"  class="btn btn-warning" class="btn btn-block" ng-click="cancelRow('certificacao')">Cancelar</button>
                                            </td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div ng-show="optionsBoolean[0] || optionsBoolean[1] || optionsBoolean[2] || optionsBoolean[3]">
                                <button class="btn btn-primary" ng-click="save(selecionado)">Salvar</button>
                                <button class="btn btn-danger" ng-click="remove(selecionado)">Deletar</button>
                                <button class="btn btn-info" ng-click="exportType('xls')" type="button">Gerar Relatório</button>
                            </div><br><br><br>
                        </div>
                        <div class="dropdown" ng-hide="optionsBoolean[0] || optionsBoolean[1] || optionsBoolean[2] || optionsBoolean[3]">
                            <button class="btn btn-danger" ng-click="remove(selecionado)" ng-show="selecionado">Deletar</button>
                            <button class="btn btn-info" ng-click="exportType('xls')" type="button">Gerar Relatório</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <div id="loader">
            <img class="gifLoader" src="resources/imgs/loader4.gif" class="ajax-loader"/>
        </div>
    </body>
</html>
